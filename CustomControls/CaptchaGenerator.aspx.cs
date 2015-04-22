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
using System.Xml.Linq;
using System.Drawing;
using System.Drawing.Text;
using System.Drawing.Imaging;

public partial class CustomControls_CaptchaGenerator : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Expires = 0;
        Response.Cache.SetNoStore();
        Response.AppendHeader("Pragma", "no-cache");

        Bitmap objBMP = new Bitmap(90, 30);
        Graphics objGraphics = Graphics.FromImage(objBMP);
        objGraphics.Clear(Color.CadetBlue);
        objGraphics.TextRenderingHint = TextRenderingHint.AntiAlias;
        // Configure font to use for text

        Font objFont = new Font("Arial", 15, FontStyle.Italic);
        string randomStr = "";
        char[] myArray = new char[5];
        int x;
        //That is to create the random # and add it to our string
        Random autoRand = new Random();
        for (x = 0; x < 5; x++)
        {
            myArray[x] = System.Convert.ToChar(autoRand.Next(65,90));
            randomStr += (myArray[x].ToString());
        }
        //This is to add the string to session, to be compared later
        Session.Add("CaptchaKey", randomStr);
        // Write out the text
        objGraphics.DrawString(randomStr, objFont, Brushes.White, 5, 5);
        //' Set the content type and return the image
        Response.ContentType = "image/GIF";
        objBMP.Save(Response.OutputStream, ImageFormat.Gif);
        objFont.Dispose();
        objGraphics.Dispose();
        objBMP.Dispose();
    }
}
