using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using TQO_Classes;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["q"] == "" || Request.QueryString["q"] == null)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                cell.Text = "No Results found for the search criteria.";
                row.Cells.Add(cell);
                tblSearchResult.Rows.Add(row);
            }
            else
            {
                UserTenant tenants = new UserTenant();
                tenants.GetConfirmedTenants();

                SearchEngine engine = new SearchEngine();
                List<SearchResult> results = engine.GeneralSearch(Request.QueryString["q"], tenants.TenantCollection);

                //Persist the search string, so as to aid result ratings
                Session["SearchString"] = Request.QueryString["q"];
                //Switch to know the type of search a user is carrying out
                Session["Switch"] = "GenSearch";

                if (results.Count <= 0)
                {
                    TableRow row = new TableRow();
                    TableCell cell = new TableCell();
                    cell.Text = "No Results found for the search criteria.";
                    row.Cells.Add(cell);
                    tblSearchResult.Rows.Add(row);
                }
                else
                {
                    //Sort the results by rating
                    results = SortSearchRatings(results);

                    foreach (SearchResult result in results)
                    {
                        TableRow[] rows = new TableRow[2];

                        //For the Link                    
                        TableCell cell = new TableCell();

                        //For the Excerpt
                        TableRow row2 = new TableRow();
                        TableCell cell2 = new TableCell();

                        LinkButton lnkBtn = new LinkButton();
                        lnkBtn.ID = result.Url;
                        lnkBtn.Text = result.Title;
                        lnkBtn.PostBackUrl = result.Url;

                        cell.Controls.Add(lnkBtn);

                        cell2.Text = "<span style=\"font-size:medium; font-family:Century Gothic; font-style:italic; color:Gray\">" +
                                           result.Excerpt + "</span>";


                        rows[0] = new TableRow();
                        rows[0].Cells.Add(cell);

                        rows[1] = new TableRow();
                        rows[1].Cells.Add(cell2);

                        tblSearchResult.Rows.AddRange(rows);

                        lnkNewRelevant.Visible = true;
                        hlnkInfo.Visible = true;
                    }
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //Clear the table off of the former results
        tblSearchResult.Rows.Clear();

        //Get all users
        UserTenant tenants = new UserTenant();
        tenants.GetAll();

        SearchEngine engine = new SearchEngine();
        List<SearchResult> results = engine.GeneralSearch(txtSearchBox.Text, tenants.TenantCollection);

        //Persist the search string, so as to aid result ratings
        Session["SearchString"] = txtSearchBox.Text;
        //Switch to know the type of search a user is carrying out
        Session["Switch"] = "GenSearch";

        if (results.Count <= 0)
        {
            TableRow row = new TableRow();
            TableCell cell = new TableCell();
            cell.Text = "No Results found for the search criteria.";
            row.Cells.Add(cell);
            tblSearchResult.Rows.Add(row);
        }
        else
        {
            //Sort the results by rating
            results = SortSearchRatings(results);         

            foreach (SearchResult result in results)
            {
                TableRow[] rows = new TableRow[2];

                //For the Link
                TableCell cell = new TableCell();

                //For the Excerpt
                TableCell cell2 = new TableCell();

                LinkButton lnkBtn = new LinkButton();
                lnkBtn.ID = result.Url;
                lnkBtn.Text = result.Title;
                lnkBtn.PostBackUrl = result.Url;
                //lnkBtn.Click += new EventHandler(lnkBtnRating_Click);

                Page.Controls.Add(lnkBtn);

                cell.Controls.Add(lnkBtn);

                cell2.Text = "<span style=\"font-size:medium; font-family:Century Gothic; font-style:italic; color:Gray\">" +
                                   result.Excerpt + "</span>";


                rows[0] = new TableRow();
                rows[0].Cells.Add(cell);

                rows[1] = new TableRow();
                rows[1].Cells.Add(cell2);

                tblSearchResult.Rows.AddRange(rows);
                
                lnkNewRelevant.Visible = true;
                hlnkInfo.Visible = true;
            }
        }  
    }

    protected void btnAdvSearch_Click(object sender, EventArgs e)
    {
        SearchEngine engine = new SearchEngine();
        List<CategorySearchResult> results = engine.GeneralCategorySearch(txtSearchBox.Text, drpCategory.SelectedValue,
                                                                          txtState.Text, drpCountry.SelectedItem.Text, false);

        //Clear the table off of the former results
        tblSearchResult.Rows.Clear();

        if (results.Count <= 0)
        {
            TableRow row = new TableRow();
            TableCell cell = new TableCell();
            cell.Text = "No Results found for the search criteria.";
            row.Cells.Add(cell);
            tblSearchResult.Rows.Add(row);
        }
        else
        {
            //Sort the results by rating
            results = SortSearchRatings(results);

            //Persist the search string, so as to aid result ratings
            Session["SearchString"] = txtSearchBox.Text;
            //Switch to know the type of search a user is carrying out
            Session["Switch"] = "CateSearch";

            foreach (CategorySearchResult result in results)
            {
                TableRow[] rows = new TableRow[2];

                //For the Link                
                TableCell cell = new TableCell();

                //For the Excerpt
                TableCell cell2 = new TableCell();

                LinkButton lnkBtn = new LinkButton();
                lnkBtn.ID = result.SiteURL;
                lnkBtn.Text = result.CompanyName;
                lnkBtn.PostBackUrl = result.SiteURL;
                //lnkBtn.Click += new EventHandler(lnkBtnRating_Click);

                cell.Controls.Add(lnkBtn);
                
                cell2.Text = "<span style=\"font-size:small; font-family:Century Gothic; font-style:italic; color:Gray\">" +
                                   result.SiteDescription + "</span>" +
                             "<br /><span style=\"font-family:Century Gothic; font-size:smaller; color: #3399FF\">" +
                                   result.Address + "<br />" + result.City + ", " + result.State +
                             "<br />" + result.Country + "<br />" + result.PhoneNumber + "</span>&nbsp;&nbsp;&nbsp;&nbsp;";

                rows[0] = new TableRow();
                rows[0].Cells.Add(cell);

                rows[1] = new TableRow();
                rows[1].Cells.Add(cell2);

                tblSearchResult.Rows.AddRange(rows);

                lnkNewRelevant.Visible = true;
                hlnkInfo.Visible = true;
            }
        }
    }

    protected void drpState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpState.SelectedValue.StartsWith("Non"))
        {
            txtState.Text = "";
            pnlState.Visible = true;
        }
        else
        {
            txtState.Text = drpState.SelectedValue;
            pnlState.Visible = false;
        }
    }

    /// <summary>
    /// Method to store and sort search ratings for SearchResult
    /// </summary>
    /// <param name="results">The search result to be sorted</param>
    private List<SearchResult> SortSearchRatings(List<SearchResult> results)
    {
        //Get the current keyword
        string keyword = Session["SearchString"].ToString();
        SearchRating rating = null;

        foreach (SearchResult result in results)
        {
            try
            {
                rating = new SearchRating();
                rating.Keyword = keyword;
                rating.SiteURL = result.Url.Remove(result.Url.LastIndexOf('&'));
                rating.Rating = 1;
                rating.DomainID = 1;

                rating.Add();
            }
            catch (Exception ex)
            {
                continue;
            }
        }

        //Sort/Rank Search results
        SearchRating ratings = new SearchRating();
        ratings.Keyword = keyword;
        ratings.DomainID = 1;
        ratings.Sort();

        List<SearchResult> NewResult = new List<SearchResult>();
        
        //Get sorted results
        foreach (SearchRating srating in ratings.SearchRatingCollection)
        {
            foreach (SearchResult result in results)
            {
                if (srating.SiteURL.Equals(result.Url.Remove(result.Url.LastIndexOf('&'))))
                {
                    SearchResult sresult = new SearchResult(result.Url, result.Title, result.Excerpt);

                    NewResult.Add(sresult);
                    break;
                }
            }
        }

        return NewResult;
    }

    /// <summary>
    /// Method to store and sort search ratings for CategorySearchResult
    /// </summary>
    /// <param name="results">The search result to be sorted</param>
    private List<CategorySearchResult> SortSearchRatings(List<CategorySearchResult> results)
    {
        //Get the current key word
        string keyword = Session["SearchString"].ToString();

        //Sort/Rank Search results
        SearchRating ratings = new SearchRating();
        ratings.Keyword = keyword;
        ratings.DomainID = 1;
        ratings.Sort();

        List<CategorySearchResult> NewResult = new List<CategorySearchResult>();

        try
        {
            //Get sorted results
            foreach (SearchRating srating in ratings.SearchRatingCollection)
            {
                foreach (CategorySearchResult result in results)
                {
                    if (srating.SiteURL.Equals(result.SiteURL))
                    {
                        CategorySearchResult sresult = new CategorySearchResult();
                        sresult.CompanyName = result.CompanyName;
                        sresult.Address = result.Address;
                        sresult.City = result.City;
                        sresult.State = result.State;
                        sresult.Country = result.Country;
                        sresult.Category = result.Category;
                        sresult.PhoneNumber = result.PhoneNumber;
                        sresult.SiteDescription = result.SiteDescription;
                        sresult.SiteURL = result.SiteURL;

                        NewResult.Add(sresult);
                        break;
                    }
                }
            }
        }
        catch
        {
        }

        return NewResult;
    }

    protected void lnkNewRelevant_Click(object sender, EventArgs e)
    {
        if(Session["Switch"] == null) return;

        if (Session["Switch"].ToString().Equals("GenSearch"))
        {
            //Clear the table off of the former results
            tblSearchResult.Rows.Clear();

            //Get all users
            UserTenant tenants = new UserTenant();
            tenants.GetAllBySetupDate();

            SearchEngine engine = new SearchEngine();
            List<SearchResult> results = engine.GeneralSearch(txtSearchBox.Text, tenants.TenantCollection);

            if (results.Count <= 0)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                cell.Text = "No Results found for the search criteria.";
                row.Cells.Add(cell);
                tblSearchResult.Rows.Add(row);
            }
            else
            {
                //Sort the results by rating
                results = SortSearchRatings(results);

                //Persist the search string, so as to aid result ratings
                Session["SearchString"] = txtSearchBox.Text;
                //Switch to know the type of search a user is carrying out
                Session["Switch"] = "GenSearch";

                foreach (SearchResult result in results)
                {
                    TableRow[] rows = new TableRow[2];

                    //For the Link                    
                    TableCell cell = new TableCell();

                    //For the Excerpt
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();

                    LinkButton lnkBtn = new LinkButton();
                    lnkBtn.ID = result.Url;
                    lnkBtn.Text = result.Title;
                    lnkBtn.PostBackUrl = result.Url;
                    //lnkBtn.Click += new EventHandler(lnkBtnRating_Click);

                    cell.Controls.Add(lnkBtn);

                    cell2.Text = "<span style=\"font-size:medium; font-family:Century Gothic; font-style:italic; color:Gray\">" +
                                       result.Excerpt + "</span>";


                    rows[0] = new TableRow();
                    rows[0].Cells.Add(cell);

                    rows[1] = new TableRow();
                    rows[1].Cells.Add(cell2);

                    tblSearchResult.Rows.AddRange(rows);
                }
            }
            lnkNewRelevant.Visible = false;
            hlnkInfo.Visible = false;
        }
        else
        {
            SearchEngine engine = new SearchEngine();
            List<CategorySearchResult> results = engine.GeneralCategorySearch(txtSearchBox.Text, drpCategory.SelectedValue,
                                                                              txtState.Text, drpCountry.SelectedItem.Text, true);

            //Clear the table off of the former results
            tblSearchResult.Rows.Clear();

            if (results == null)
            {
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                cell.Text = "No Results found for the search criteria.";
                row.Cells.Add(cell);
                tblSearchResult.Rows.Add(row);
            }
            else
            {
                //Sort the results by rating
                results = SortSearchRatings(results);

                //Persist the search string, so as to aid result ratings
                Session["SearchString"] = txtSearchBox.Text;
                //Switch to know the type of search a user is carrying out
                Session["Switch"] = "CateSearch";

                foreach (CategorySearchResult result in results)
                {
                    TableRow[] rows = new TableRow[2];

                    //For the Link                    
                    TableCell cell = new TableCell();

                    //For the Excerpt
                    TableRow row2 = new TableRow();
                    TableCell cell2 = new TableCell();

                    LinkButton lnkBtn = new LinkButton();
                    lnkBtn.ID = result.SiteURL;
                    lnkBtn.Text = result.CompanyName;
                    lnkBtn.PostBackUrl = result.SiteURL;
                    //lnkBtn.Click += new EventHandler(lnkBtnRating_Click);

                    cell.Controls.Add(lnkBtn);

                    cell2.Text = "<span style=\"font-size:small; font-family:Century Gothic; font-style:italic; color:Gray\">" +
                                       result.SiteDescription + "</span>" +
                                 "<br /><span style=\"font-family:Century Gothic; font-size:smaller; color: #3399FF\">" +
                                       result.Address + "<br />" + result.City + ", " + result.State +
                                 "<br />" + result.Country + "<br />" + result.PhoneNumber + "</span>&nbsp;&nbsp;&nbsp;&nbsp;";

                    rows[0] = new TableRow();
                    rows[0].Cells.Add(cell);

                    rows[1] = new TableRow();
                    rows[1].Cells.Add(cell2);

                    tblSearchResult.Rows.AddRange(rows);
                }
            }
            lnkNewRelevant.Visible = false;
            hlnkInfo.Visible = false;
        }
    }
}
