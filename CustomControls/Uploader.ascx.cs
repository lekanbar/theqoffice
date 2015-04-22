using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using TQO_Classes;
using QOffice.Utility;

public partial class CustomControls_Uploader : System.Web.UI.UserControl
{
    private Guid _UserID;
    private string[] _FileTypes;
    private string _CssClass;
    private bool _IsValid;
    private bool _AllowMultiple;

    public Guid UserID
    {
        get { return _UserID; }
        set { _UserID = value; }
    }

    public string[] FileTypes
    {
        get { return _FileTypes; }
        set { _FileTypes = value; }
    }

    public string CssClass
    {
        get { return _CssClass; }
        set { _CssClass = value; }
    }

    public bool IsValid
    {
        get { return _IsValid; }
        set { _IsValid = value; }
    }

    public bool AllowMultiple
    {
        get { return _AllowMultiple; }
        set { _AllowMultiple = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (AllowMultiple)
        {
            pnlIFrame.Visible = false;
            pnlIFrameMultiple.Visible = true;

            if (Session["fileCollection"] != null)
            {
                pnlC2.Visible = false;
                pnlFileUploadDetails2.Visible = true;
            }
            else
            {
                pnlFileUploadDetails2.Visible = false;
            }
        }
        else
        {
            pnlIFrame.Visible = true;
            pnlIFrameMultiple.Visible = false;

            if (Session["fileURL"] != null)
            {
                Random ran = new Random();
                imgUploadedImage.ImageUrl = Session["fileURL"].ToString() + "?id=" + ran.Next(1, 9);

                if (Session["fileSize"] != null)
                    lblSize.Text = Session["fileSize"].ToString();
                else
                    lblSize.Text = "--";
                if (Session["fileType"] != null)
                    lblType.Text = Session["fileType"].ToString();
                else
                    lblType.Text = "--";

                pnlImage.Visible = true;
                pnlC1.Visible = false ;
                pnlFileUploadDetails.Visible = true;
            }
            else { pnlImage.Visible = false; pnlFileUploadDetails.Visible = false; }
        }

        if (CssClass != "")
            pnlIFrame.CssClass = CssClass;
    }

    protected void btnUploaded_Click(Object sender, System.EventArgs e)
    {
        if (AllowMultiple)
        {
            HttpFileCollection HFC = Session["UploadedFiles"] as HttpFileCollection;
            string[] FileCollection = new string[HFC.Count];
            int counter = 0; //To count only valid files

            for (int i = 0; i < HFC.Count; i++)
            {
                HttpPostedFile HPF = HFC[i];
                if (HPF.ContentLength > 0)
                {
                    if (this.FileTypes[0] == "Picture")
                    {
                        FileCollection[counter] = UploadHelper.UploadPicture(HPF, this.UserID);
                    }
                    else if (this.FileTypes[0] == "GalleryPicture")
                    {
                        FileCollection[counter] = UploadHelper.UploadGalleryPicture(HPF, this.UserID);
                    }
                    else
                    {
                        FileCollection[counter] = UploadHelper.UploadFiles(HPF, this.FileTypes, this.UserID, true);
                    }
                    counter++;
                }
            }

            Session["fileCollection"] = FileCollection;

            pnlC2.Visible = false;
            pnlFileUploadDetails2.Visible = true;

            IsValid = true;
        }
        else
        {
            //Upload file onto server
            FileUpload UploadControl = Session["UploadControl"] as FileUpload;

            if (this.FileTypes[0] == "Logo")
            {
                Session["fileURL"] = UploadHelper.UploadLogos(UploadControl, this.UserID);
                GetFileSize(UploadControl);
                GetFileType();
                pnlImage.Visible = true;
                imgUploadedImage.ImageUrl = Session["fileURL"].ToString();
            }
            else if (this.FileTypes[0] == "Picture")
            {
                Session["fileURL"] = UploadHelper.UploadPicture(UploadControl, this.UserID);
                GetFileSize(UploadControl);
                GetFileType();
                pnlImage.Visible = true;
                imgUploadedImage.ImageUrl = Session["fileURL"].ToString();
            }
            else if (this.FileTypes[0] == "GalleryPicture")
            {
                Session["fileURL"] = UploadHelper.UploadGalleryPicture(UploadControl, this.UserID);
                GetFileSize(UploadControl);
                GetFileType();
                pnlImage.Visible = true;
                imgUploadedImage.ImageUrl = Session["fileURL"].ToString();
            }
            else if (this.FileTypes[0] == "ProfilePicture")
            {
                Session["fileURL"] = UploadHelper.UploadProfilePicture(UploadControl, this.UserID);
                GetFileSize(UploadControl);
                GetFileType();
                pnlImage.Visible = true;
                imgUploadedImage.ImageUrl = Session["fileURL"].ToString();
            }
            else
            {
                Session["fileURL"] = UploadHelper.UploadFiles(UploadControl, this.FileTypes, this.UserID, true);
                GetFileSize(UploadControl);
                GetFileType();
            }

            if (Session["fileSize"] != null)
                lblSize.Text = Session["fileSize"].ToString();
            else
                lblSize.Text = "--";
            if (Session["fileType"] != null)
                lblType.Text = Session["fileType"].ToString();
            else
                lblType.Text = "--";

            IsValid = true;
            pnlC1.Visible = false;
            pnlFileUploadDetails.Visible = true;
        }
    }

    protected void btnRefresh_Click(Object sender, System.EventArgs e)
    {
        if(!AllowMultiple)
            pnlImage.Visible = false;
    }

    protected void btnReset_Click(Object sender, System.EventArgs e)
    {
        if (Session["fileURL"] != null)
            QOffice.Utility.FileHelper.DeleteFile(Session["fileURL"].ToString());

        CleanUp();

        pnlC1.Visible = true;
        pnlFileUploadDetails.Visible = false;

    }

    protected void btnReset2_Click(Object sender, System.EventArgs e)
    {
        if (Session["fileCollection"] != null)
            QOffice.Utility.FileHelper.DeleteMultipleFiles(Session["fileCollection"] as string[]);

        CleanUp();

        pnlC2.Visible = true;
        pnlFileUploadDetails2.Visible = false;        
    }

    public void CleanUp()
    {
        Session["fileURL"] = null;
        Session["fileSize"] = null;
        Session["fileType"] = null;
        Session["fileCollection"] = null;
        Session["UploadedFiles"] = null;
        pnlImage.Visible = false;
        pnlFileUploadDetails.Visible = false;
        pnlFileUploadDetails2.Visible = false;
        if (AllowMultiple)
            pnlC2.Visible = true;
        else pnlC1.Visible = true;
    }

    private void GetFileSize(FileUpload UploadControl)
    {
        long ByteLength = UploadControl.FileContent.Length;
        if (ByteLength < 1024)
            Session["fileSize"] = ByteLength.ToString() + " Bytes";
        else if (ByteLength < (1024*1024))
            Session["fileSize"] = (ByteLength/1024).ToString() + " KB";
        else
            Session["fileSize"] = (ByteLength / (1024 ^ 2)).ToString() + " MB";
    }

    private void GetFileType()
    {
        Session["FileType"] = Path.GetExtension(Session["fileURL"].ToString());
    }
}
