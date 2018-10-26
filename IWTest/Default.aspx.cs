using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using IWTest.Models;

namespace IWTest
{
    public partial class _Default : Page
    {

        private IWTestEntities DBContext;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadIndividuals();

            }
        }

        /// <summary>
        /// Load Individual list and refresh update panel
        /// </summary>
        private void LoadIndividuals()
        {
            try
            {
                DBContext = new IWTestEntities();
                var Individuals = DBContext.Individual.ToList();
                IndividualsGridView.DataSource = Individuals;
                IndividualsGridView.DataBind();

                UpdatePanelGrid.Update();
                IndividualsGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script2", "initTable();", true);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "alert('" + ex.Message + "');", true);
            }

        }

        /// <summary>
        /// Get a list addresses by Individual ID
        /// </summary>
        /// <param name="individualId"></param>
        /// <returns>List<Address></returns>
        protected List<Address> GetAddressByIndividual(int individualId)
        {
            try
            {
                DBContext = new IWTestEntities();
                return (from a in DBContext.Address
                        join ia in DBContext.IndividualAddress on a.id equals ia.AddressId
                        where ia.IndividualId == individualId
                        select a).ToList();


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "alert('" + ex.Message + "');", true);
                return null;
            }


        }

        /// <summary>
        /// Merge individuals deleting the second one
        /// and adding its addresses to the first one
        /// </summary>
        /// <param name="individualId1">Id of the first Individual</param>
        /// <param name="individualId2">Id of the second Individual</param>
        protected void MergeIndividuals(int individualId1, int individualId2)
        {
            try
            {
                DBContext = new IWTestEntities();

                DBContext.IndividualAddress.Where(x => individualId2 == x.IndividualId).ToList()
                    .ForEach(a => a.IndividualId = individualId1);

                var ind = (from y in DBContext.Individual
                           where y.id == individualId2
                           select y).FirstOrDefault();
                DBContext.Individual.Remove(ind);

                DBContext.SaveChanges();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "alert('" + ex.Message + "');", true);

            }
        }

        protected void IndividualsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewAddresses")
            {
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                int id = int.Parse(this.IndividualsGridView.DataKeys[rowIndex]["id"].ToString());
                string fullName = this.IndividualsGridView.DataKeys[rowIndex]["firstname"].ToString() + ' ' + this.IndividualsGridView.DataKeys[rowIndex]["lastname"].ToString();

                ShowIndividualAddresses(id, fullName);
            }
        }

        private void ShowIndividualAddresses(int id, string fullName)
        {
            lblName.Text = fullName;

            GridViewIndividualDetail.DataSource = GetAddressByIndividual(id);
            GridViewIndividualDetail.DataBind();
            UpdatePanelIndividualDetail.Update();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script3", "$('#modalDetail').show();", true);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script4", "initPage();", true);
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "$('#modalDetail').hide();", true);
        }

        protected void btnMergePreview_Click(object sender, EventArgs e)
        {
            individualAddressGrid1.DataSource = GetAddressByIndividual(int.Parse(this.IndividualId1.Value));
            individualAddressGrid1.DataBind();
            LabelIndividualName1.Text = IndividualName1.Value;

            individualAddressGrid2.DataSource = GetAddressByIndividual(int.Parse(this.IndividualId2.Value));
            individualAddressGrid2.DataBind();
            LabelIndividualName2.Text = IndividualName2.Value;

            UpdatePanelMergePreview.Update();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "$('#modalMerge').show();", true);

        }

        protected void btnMerge_Click(object sender, EventArgs e)
        {
            MergeIndividuals(int.Parse(this.IndividualId1.Value), int.Parse(this.IndividualId2.Value));
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "$('#modalMerge').hide();", true);
            LoadIndividuals();
            ShowIndividualAddresses(int.Parse(this.IndividualId1.Value), IndividualName1.Value);

        }
    }
}