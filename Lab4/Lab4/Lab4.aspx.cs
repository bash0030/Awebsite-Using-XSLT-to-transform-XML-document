using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Web.Configuration;

public partial class Lab4 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Create the transformation. For better performance cache the compiled XSLT in the session. 

        XslCompiledTransform transform = null;
        if (Application["xslt"] == null)
        {
            transform = new XslCompiledTransform();


            // this is the better way we have to use for path:
            //string xsltPath = WebConfigurationManager.AppSettings["xsltPath"];

            //we can use this below way, but the first one is the one we have to use:
            string xsltPath = MapPath(@"~/App_Data/XSLTFile1.xslt");
            transform.Load(xsltPath);
            Application["xslt"] = transform;
        }
        //else
        //{
        //    transform = Application["xslt"] as XslCompiledTransform;
        //}

        //Session["restaurantReviewXslt"] = transform;

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //retrieve compiled XSLT in the session.
        XslCompiledTransform transform = Application["xslt"] as XslCompiledTransform;

        //create the XSLT parameters 

        int minRating = int.Parse(txtMinRating.Text);
        XsltArgumentList xslArguments = new XsltArgumentList();
        xslArguments.AddParam("minRating", "", minRating.ToString());


        //create transformation output string.
        StringBuilder htmlStringBuilder = new StringBuilder();
        XmlWriter xw = XmlWriter.Create(htmlStringBuilder);


        //transform the xml
        //string xmlPath = WebConfigurationManager.AppSettings["xmlPath"];
        string xmlPath = MapPath(@"~/App_Data/restaurant_reviews.xml");
        transform.Transform(xmlPath, xslArguments, xw);


        //add transformation result to the page.
        string htmlString = htmlStringBuilder.ToString();
        divRestaurantReviews.InnerHtml = htmlString;


    }
}