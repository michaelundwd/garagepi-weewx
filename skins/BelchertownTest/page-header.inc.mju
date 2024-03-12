#encoding UTF-8
<!--#mju = modified Mar 2021 for Nexus 10 -->
<div class="wx-stn-info-container">
    <div class="row">
        <div class="col-sm-1 wx-stn-info-current-obs">
            <span class="obs-header-icon"><a href = "../"  color="inherit" itemprop="url">
                #if $Extras.has_key("forecast_enabled") and $Extras.forecast_enabled == '1' and $current_obs_icon != ""
                <img id="wxicon" src="$relative_url/images/$current_obs_icon">
                #end if
            </span></a>
            <span class="obs-header-outtemp">$current.outTemp</span>
        </div>
        <div class="col-sm-5">
            <div class="nexus-observations-area">
                <div class="wx-stn-name">
            #if $page == "graphs"
                    <h1>$obs.label.graphs_page_header</h1>
            #else if $page == "records"
                    <h1>$obs.label.records_page_header</h1>
            #else if $page == "reports"
                    <h1>$obs.label.reports_page_header</h1>
            #else if $page == "about"
                    <h1>$obs.label.about_page_header</h1>
            #end if
                </div>
            </div>
        </div>
        <div class="col-sm-5" style="float:right;">
            <div class="wx-stn-info">
                $obs.label.powered_by
            </div>
            #if $social_html != ""
            <div class="col-sm-10 wx-stn-info-social" style="float:right;">
                $social_html
            </div>
            #end if
        </div>
        
        <!-- this widget area from header is normally hidden, only displayed for nexus 10 via css -->
        <div class="widget-area nexus10-widget-area" style="display:none">
            <section id="nav_menu">
                <div class="widget-wrap">
                    <nav class="nav-header" itemscope itemtype="https://schema.org/SiteNavigationElement">
                        <ul id="menu-menu" class="menu genesis-nav-menu">
                            <!-- class = current-menu-item -->
                            <li class="menu-item menu-item-home"><a href="$relative_url" itemprop="url"><span itemprop="name">$obs.label.nav_home</span></a></li>
                            #if $Extras.has_key('highcharts_enabled') and $Extras.highcharts_enabled == '1'
                            <li class="menu-item menu-item-1"><a href="$relative_url/graphs" itemprop="url"><span itemprop="name">$obs.label.nav_graphs</span></a></li>
                            #end if
                            <li class="menu-item menu-item-2"><a href="$relative_url/records" itemprop="url"><span itemprop="name">$obs.label.nav_records</span></a></li>
                            <li class="menu-item menu-item-3"><a href="$relative_url/reports" itemprop="url"><span itemprop="name">$obs.label.nav_reports</span></a></li>
                            <li class="menu-item menu-item-4"><a href="$relative_url/about" itemprop="url"><span itemprop="name">$obs.label.nav_about</span></a></li>
                        </ul>
                    </nav>
                </div>
            </section>
        </div>
                            
        
    </div>
    <div class="clear"></div>
</div>
