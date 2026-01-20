using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PHX_MEERA
{
    public partial class Break : System.Web.UI.Page
    {
        // Configuration - Edit these values
        private DashboardConfig Config = new DashboardConfig
        {
            Target = 0,
            Actual = 0,
            FTC = 0,
            Overcycle = 0
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize dashboard with default values
                LoadDashboardData();
            }
            else
            {
                // Handle postback - refresh data
                LoadDashboardData();
            }
        }

        /// <summary>
        /// Load dashboard data - Replace this with your actual data source
        /// </summary>
        private void LoadDashboardData()
        {
            // EXAMPLE: Get data from database, API, or other source
            // Replace these with your actual data retrieval logic

            try
            {
                // Example: Get from database
                // Config.Target = GetTargetFromDatabase();
                // Config.Actual = GetActualFromDatabase();
                // Config.FTC = GetFTCFromDatabase();
                // Config.Overcycle = GetOvercycleFromDatabase();

                // For now, using config values or you can hardcode for testing
                // Config.Target = 100;
                // Config.Actual = 95;
                // Config.FTC = 5;
                // Config.Overcycle = 2;
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error loading dashboard data: " + ex.Message);
            }
        }

        /// <summary>
        /// Public method to update metrics from other pages/classes
        /// </summary>
        /// <param name="target">Target value</param>
        /// <param name="actual">Actual value</param>
        /// <param name="ftc">FTC value</param>
        /// <param name="overcycle">Overcycle value</param>
        public void UpdateMetrics(int target, int actual, int ftc, int overcycle)
        {
            Config.Target = target;
            Config.Actual = actual;
            Config.FTC = ftc;
            Config.Overcycle = overcycle;
        }

        // Example: Methods to get data from database
        // Uncomment and implement based on your data source


        private int LoadTarget(string line)
        {
            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["PRODAPUSM"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(
                "[ms_spec].[GetTargetNumbersInEachZone]", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@zone", line);

                conn.Open();

                object result = cmd.ExecuteScalar();

                return (result == null || result == DBNull.Value)
                    ? 0
                    : Convert.ToInt32(result);
            }
        }

        private int LoadActual(string line)
        {
            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["PRODAPUSM_DWH"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(
                "[ms_ssrs].[GetActualNumbersInEachZone]", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@zone", line);

                conn.Open();

                object result = cmd.ExecuteScalar();

                return (result == null || result == DBNull.Value)
                    ? 0
                    : Convert.ToInt32(result);
            }
        }

        /*
        private int LoadFTC(string line)
        {
           using (SqlConnection conn = new SqlConnection(
              ConfigurationManager.ConnectionStrings["PRODAPUSM"].ConnectionString))
           using (SqlCommand cmd = new SqlCommand(
             "[Waiting for Iris]", conn))
          {
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@zone", line);

        conn.Open();

        object result = cmd.ExecuteScalar();

        return (result == null || result == DBNull.Value)
            ? 0
            : Convert.ToInt32(result);
                }
            }
            */

        /*
        private int LoadOvercycle(string line)
        {
           using (SqlConnection conn = new SqlConnection(
              ConfigurationManager.ConnectionStrings["PRODAPUSM"].ConnectionString))
           using (SqlCommand cmd = new SqlCommand(
             "[Waiting for Iris]", conn))
          {
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@zone", line);

        conn.Open();

        object result = cmd.ExecuteScalar();

        return (result == null || result == DBNull.Value)
            ? 0
            : Convert.ToInt32(result);
                }
            }
            */

        /// <summary>
        /// Configuration class for dashboard metrics
        /// </summary>
        public class DashboardConfig
        {
            public int Target { get; set; }
            public int Actual { get; set; }
            public int FTC { get; set; }
            public int Overcycle { get; set; }
        }
    }
}