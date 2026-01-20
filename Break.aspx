<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Break.aspx.cs" Inherits="PHX_MEERA.Break" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us">
<head runat="server">
    <title>Break Dashboard Display</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html, form {
            height: 100%;
            background-color: #212529;
            color: white;               
            font-family: Arial, sans-serif;
            overflow: hidden;           
        }

        .bg-surface { background-color: #212529 !important; } 
        .bg-dark { background-color: #212529 !important; }    
        .bg-black { background-color: #000000 !important; }  
        .bg-accent { background-color: #2e73c7 !important; }   
        .bg-darkblue { background-color: #2e73c7 !important; }

        header {
            height: 8vh;      
            min-height: 50px;  
            background-color: #000000 !important; 
            color: white !important;        
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            flex-shrink: 0;                
        }

        header .header-left,
        header .header-center,
        header .header-right {
            display: flex;     
            align-items: center;    
        }

       
        header .header-left {
            font-size: clamp(1.5rem, 2.5vw, 2.5rem);
            font-weight: bold;     
            color: white;   
            white-space: nowrap;    
        }

        header .header-center {
            justify-content: center;
            color: white;           
            font-size: clamp(1.5rem, 2.5vw, 2.5rem); 
        }

        .header-logo {
            height: clamp(35px, 6vh, 70px); 
            width: auto;        
        }


        .dashboard-content {
            overflow: hidden;     
            flex: 1;               
            min-height: 0;           
        }

        .display-4 {
            font-size: clamp(1.5rem, 2.5vw, 2.5rem);
            font-weight: 600;      
        }

        .display-5 {
            font-size: clamp(0.9rem, 1.5vw, 1.5rem);
            font-weight: 600;  
        }

        .fw-bold { font-weight: bold !important; }     
        .text-black { color: #333 !important; }         
        .text-center { text-align: center; }            
        .text-end { text-align: right; }      

        .d-flex { display: flex !important; }        
        .flex-column { flex-direction: column !important; } 
        .flex-grow-1 {                                 
            flex-grow: 1 !important;
            max-height: 3000px;        
        }
        .vh-100 { height: 100vh !important; }          
        .h-100 { height: 100% !important; }   

        
        .row {
            margin-right: 0 !important; 
            margin-left: 0 !important;
        }

        .container-fluid {
            overflow-x: hidden;       
        }

        .col, .col-12 {
            flex: 1 0 0%;              
            padding-right: 0.5rem;      
            padding-left: 0.5rem;      
        }

        .col-12 {
            flex: 0 0 100%;            
            max-width: 100%;            
        }

      
        .g-2 { gap: clamp(0.25rem, 0.5vw, 0.5rem); }   
        .p-1 { padding: clamp(0.25rem, 0.5vw, 0.5rem) !important; } 
        .p-2 { padding: clamp(0.5rem, 1vw, 1rem) !important; }      
        .py-2 {                                         
            padding-top: clamp(0.5rem, 1vw, 1rem) !important;
            padding-bottom: clamp(0.5rem, 1vw, 1rem) !important;
        }
        .px-3 {                                         
            padding-left: clamp(0.75rem, 1.5vw, 1.5rem) !important;
            padding-right: clamp(0.75rem, 1.5vw, 1.5rem) !important;
        }
        .mt-2 { margin-top: clamp(0.5rem, 1vw, 1rem) !important; }  
        .mb-2 { margin-bottom: clamp(0.5rem, 1vw, 1rem) !important; } 
        .mb-0 { margin-bottom: 0 !important; }      

        
        .align-items-center { align-items: center !important; }         
        .justify-content-center { justify-content: center !important; }   
        .justify-content-between { justify-content: space-between !important; } 

        .card {
            border: 1px solid #444;     
            border-radius: 12px;       
            overflow: hidden;        
        }

        .card-header {
            padding: clamp(0.4rem, 0.8vh, 0.8rem) clamp(0.75rem, 1.5vw, 1.5rem); 
            height:15%;
        }

        .card-body {
            padding: clamp(0.5rem, 1vw, 1rem); 
            height: 60%;
        }

        
        .table {
            width: 100%; 
            height: 100%; 
            table-layout: fixed;
            margin-bottom: 0; 
            border-collapse: collapse; 
        }
                       
        .tv-grid th,
        .tv-grid td {
            font-size: clamp(2.2rem, 2.5vw, 3.5rem);
            font-weight: 800;
            padding: 1.8rem 1.2rem;
            line-height: 1.1;
        }

        .tv-grid tbody tr {
           height: 12vh;  
          min-height: 140px;
        }

        .tv-grid thead th {
        font-size: clamp(3.6rem, 4vw, 5rem);
        letter-spacing: 2px;
        height: 8vh;
         }


        .table thead th {
            background-color: #000000; 
            color: white;              
            font-weight: bold;         
            border-color: #666;       
            height: clamp(2.5rem, 4vh, 4rem); 
        }

        
        .table tbody tr {
            height: 10vh;  
            min-height: 80px; 
        }


        .table tbody tr.empty-row {
            opacity: 0.5;              
        }

        .table tbody tr:hover {
            background-color: #2a2e32; 
        }

        
        .table tbody tr.on-time {
            background-color: #1a5928 !important;
        }

        .table tbody tr.warning {
            background-color: #8b6914 !important;
        }

        .table tbody tr.Overcycle {
            background-color: #ff1a1a !important;
        }

        .kpi-row {
            height: 17vh;             
            min-height: 120px;          
            max-height: 200px;          
        }

        .kpi-card {
            border: 2px solid #444;  
        }

        .kpi-card .card-header {
            background-color: #000000 !important; 
            font-size: clamp(0.8rem, 1.3vw, 1.3rem); 
            padding: clamp(0.4rem, 0.8vh, 0.8rem); 
        }

        .card-body .d-flex .justify-content-center .align-items-center {
            height: fit-content; 
        }

        .kpi-value {
            font-size: clamp(3rem, 8vw, 8rem);  
            line-height: 1;            
        }

        
        #kpi1-target .card-body { background-color: #2e73c7 !important; } 
        #kpi1_actual.ahead .card-body { background-color: #1a5928 !important; }
        #kpi1_actual.behind .card-body { background-color: #ff1a1a !important; }
        #kpi1-FTC .card-body { background-color: #1a5928 !important; } 
        #kpi1_overcycle.overcycle .card-body { background-color: #ff1a1a !important; } 
        #kpi1_overcycle.normal .card-body { background-color: #1a5928 !important; } 

       
        .gridview-container {
            overflow-y: auto;         
            overflow-x: hidden;        
            height: 100%;             
            position: relative;     
        }

       
        .gridview-container::-webkit-scrollbar {
            width: 12px;            
        }

        .gridview-container::-webkit-scrollbar-track {
            background: #1a1d20;        
        }

        .gridview-container::-webkit-scrollbar-thumb {
            background: #555;      
            border-radius: 6px;       
        }

        .gridview-container::-webkit-scrollbar-thumb:hover {
            background: #777;    
        }
/* ================================ BREAK DASHBOARD VIEW ==============================*/
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header {
            height: 8vh;      
            min-height: 50px;  
            background-color: #000000 !important; 
            color: white !important;        
            box-shadow: 0 2px 4px rgba(0,0,0,0.3);
            flex-shrink: 0;                
        }

        .header h1 {
            font-size: 28px;
            font-weight: bold;
        }

        .header-right {
            text-align: right;
        }

        .time {
            font-size: 24px;
            font-family: 'Courier New', monospace;
        }

        .company {
            font-size: 14px;
            color: #999;
            margin-top: 5px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .metric-card {
            display: flex;
            flex-direction: column;
        }

        .metric-header {
            background-color: #2D2D2D;
            padding: 12px;
            text-align: center;
            border-radius: 8px 8px 0 0;
            font-size: 18px;
            font-weight: 600;
        }

        .metric-value {
            background-color: #2E7D9A;
            padding: 60px 0;
            text-align: center;
            border-radius: 0 0 8px 8px;
            font-size: 96px;
            font-weight: bold;
        }

        .break-section {
            grid-column: 1 / -1;
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        .break-card {
            background-color: #2E7D9A;
            padding: 30px 80px;
            border-radius: 8px;
            font-size: 32px;
            font-weight: 600;
        }

        .hidden-message {
            display: none;
            text-align: center;
            margin-top: 200px;
        }

        .hidden-message h2 {
            font-size: 32px;
            color: #666;
            margin-bottom: 10px;
        }

        .hidden-message p {
            font-size: 14px;
            color: #666;
        }

        .dashboard-content.hidden {
            display: none;
        }

        .hidden-message.visible {
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Header -->
    <header class="bg-black text-white py-2 px-3 d-flex align-items-center justify-content-between shadow">
        <div class="header-left fw-bold display-4">Break Dashboard Display</div>        
        <div class="header-center display-4 text-center flex-grow-1">
            <span id="lblTime"></span>
        </div>
                
        <div class="header-right text-end">
           <asp:Image ID="customIcon" class="header-logo" runat="server" ImageUrl="~/Img/Magnalog.png" AlternateText="Custom Icon" />
        </div>
    </header>

            <!-- Main Dashboard Content -->
            <div class="dashboard-content" id="dashboardContent">
                <div class="dashboard-grid">
                    <!-- Target -->
                    <div class="metric-card">
                        <div class="metric-header">Target</div>
                        <div class="metric-value" id="targetValue">0</div>
                    </div>

                    <!-- Actual -->
                    <div class="metric-card">
                        <div class="metric-header">Actual</div>
                        <div class="metric-value" id="actualValue">0</div>
                    </div>

                    <!-- Break Time -->
                    <div class="break-section">
                        <div class="break-card" id="breakTime">Break | 15:00</div>
                    </div>

                    <!-- FTC -->
                    <div class="metric-card">
                        <div class="metric-header">FTC</div>
                        <div class="metric-value" id="ftcValue">0</div>
                    </div>

                    <!-- Overcycle -->
                    <div class="metric-card">
                        <div class="metric-header">Overcycle</div>
                        <div class="metric-value" id="overcycleValue">0</div>
                    </div>
                </div>
            </div>

            <!-- Hidden State Message -->
            <div class="hidden-message" id="hiddenMessage">
                <h2>Dashboard Hidden</h2>
                <p id="visibilityMessage">Visible between 06:00 - 18:00</p>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        // ========================================
        // CONFIGURATION - Edit these values
        // ========================================
        const CONFIG = {
            title: "WAML2-2 Dashboard",
            company: "MAGNA",
            breakTime: "15:00",
            
            // Time-based visibility (24-hour format)
            enableTimeBasedVisibility: true,  // Set to false to always show

            showTimeRanges: [
                { start: "08:30", end: "08:45" },   // 8:30 AM - 8:45 AM
                { start: "11:00", end: "11:30" },   // 11:00 AM - 11:30 AM
                { start: "13:00", end: "13:15" }    // 1:00 PM - 1:15 PM
            ],
            
            // Initial metric values (will be overridden by server values)
            metrics: {
                target: 0,
                actual: 0,
                ftc: 100,
                overcycle: 0
            }
        };
        // ========================================

        // Apply configuration
        function applyConfig() {
            document.getElementById('dashboardTitle').textContent = CONFIG.title;
            document.getElementById('companyName').textContent = CONFIG.company;
            document.getElementById('breakTime').textContent = 'Break | ' + CONFIG.breakTime;
            
            if (CONFIG.enableTimeBasedVisibility) {
                document.getElementById('visibilityMessage').textContent = 
                    'Visible between ' + CONFIG.showTimeStart + ' - ' + CONFIG.showTimeEnd;
            }
        }

        // Update clock
        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            document.getElementById('currentTime').textContent = hours + ':' + minutes + ':' + seconds;
        }

        // Check time-based visibility
        function checkVisibility() {
            if (!CONFIG.enableTimeBasedVisibility) {
                document.getElementById('dashboardContent').classList.remove('hidden');
                document.getElementById('hiddenMessage').classList.remove('visible');
                return;
            }

            const now = new Date();
            const currentMinutes = now.getHours() * 60 + now.getMinutes();
            
            const [startHour, startMin] = CONFIG.showTimeStart.split(':').map(Number);
            const [endHour, endMin] = CONFIG.showTimeEnd.split(':').map(Number);
            
            const startMinutes = startHour * 60 + startMin;
            const endMinutes = endHour * 60 + endMin;
            
            const shouldShow = currentMinutes >= startMinutes && currentMinutes < endMinutes;
            
            if (shouldShow) {
                document.getElementById('dashboardContent').classList.remove('hidden');
                document.getElementById('hiddenMessage').classList.remove('visible');
            } else {
                document.getElementById('dashboardContent').classList.add('hidden');
                document.getElementById('hiddenMessage').classList.add('visible');
            }
        }

        // Update metrics from server or JavaScript
        function updateMetrics(target, actual, ftc, overcycle) {
            if (target !== undefined) document.getElementById('targetValue').textContent = target;
            if (actual !== undefined) document.getElementById('actualValue').textContent = actual;
            if (ftc !== undefined) document.getElementById('ftcValue').textContent = ftc;
            if (overcycle !== undefined) document.getElementById('overcycleValue').textContent = overcycle;
        }

        // Initialize on page load
        window.onload = function() {
            applyConfig();
            loadServerValues();
            updateClock();
            checkVisibility();
            
            // Update every second
            setInterval(function() {
                updateClock();
                checkVisibility();
            }, 1000);
        };

        // Optional: Auto-refresh data from server every 30 seconds
        // Uncomment if you want to periodically refresh from server
        /*
        setInterval(function() {
            __doPostBack('', '');
        }, 30000);
        */
    </script>
</body>
</html>
