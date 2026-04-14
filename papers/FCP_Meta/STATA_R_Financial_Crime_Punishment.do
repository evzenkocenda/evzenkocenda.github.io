******************************************************************************
******************************************************************************
* A Meta-Analysis on market reactions to disclosure of intentional financial crimes
******************************************************************************
******************************************************************************
* July 17, 2022

clear all
set more off
cd "D:\Documents\Thesis\Gestion_réglementaire\STATA\Meta"

*********************************************
*Excel import of the dataset + creation of files 
*********************************************

*WHOLE DATASET
import excel "D:\Documents\Thesis\Gestion_réglementaire\Meta_Ana\revue_literature.xlsx", sheet("dataset_financial_crime_punishment") cellrange (A1:ES481) firstrow

******************************************************************************
* Summary statistics
******************************************************************************

gen invnobs = 1/nb_ests_perstudy
gen invsqrtnobs=1/sqrt(nb_ests_perstudy)
gen invnobs_usa = 1/nb_ests_perstudy_usa
gen invnobs_non_usa = 1/nb_ests_perstudy_nonusa
gen invnobs_acc = 1/nb_ests_perstudy_account
gen invnobs_non_acc = 1/nb_ests_perstudy_nonaccount
gen length_ev_wind=event_w_end-event_w_begin+1
gen citations=ln(nb_citations_google_scholar/(2020-year+1)+1)
gen ln_sample_size=ln(sample_size)
gen mid_point=ln(avg_year_data-1973+1)
gen ln_pub_year = ln(year - 1984 +1)
gen ln_nb_years_data = ln(nb_years_data)

*Normalized length event window 
replace length_ev_wind=length_ev_wind/4.091116
*Normalization of the average year of the sample 
replace avg_year_data=avg_year_data/1999.663
*Normalization of the number of years in the sample 
replace nb_years_data=nb_years_data/11.1959
*Normalization market liquidity 
replace mkt_liquidity=mkt_liquidity/115.3717
*Normalization nb authors 
replace nb_authors=nb_authors/2.328018
*Normalization sample size 
replace sample_size=sample_size/276.4784
*Normalization confidence WVS 
replace conf_gov_wvs=conf_gov_wvs/32.84151
gen priv_enforcement=1 if stock_mkt_proc==1
replace priv_enforcement=1 if class_action==1 
replace priv_enforcement=1 if lawsuits==1
replace priv_enforcement=1 if settlements==1

*Winsorization at 1%
winsor coef_impact_day, gen(coef_impact_day_w1) p(0.01)
winsor coef_impact, gen(coef_impact_w1) p(0.01)
winsor t_stat_wcs, gen(t_stat_wcs_w1) p(0.01)
winsor standard_error_wcs, gen(standard_error_wcs_w1) p(0.01)
winsor standard_error_wcs_day, gen(standard_error_wcs_day_w1) p(0.01)

******************************************************************************
*CALCULATIONS FOR TABLEs 1 
******************************************************************************
* Table 1-A: CAAR and AAR and winsorized
*Simple avg
mean coef_impact_w1
mean coef_impact_w1 if only_account==1
mean coef_impact_w1 if only_reg_secur_laws==1
mean coef_impact_w1 if reg_secur_laws_incl_account==1
mean coef_impact_w1 if regulatory_proc==1
mean coef_impact_w1 if priv_enforcement==1
mean coef_impact_w1 if alleged_fraud==1
mean coef_impact_w1 if alleged_fraud==0
mean coef_impact_w1 if source_press==1
mean coef_impact_w1 if source_firm==1
mean coef_impact_w1 if source_reg==1
mean coef_impact_w1 if only_usa==1
mean coef_impact_w1 if common_law==1
mean coef_impact_w1 if common_law==0
mean coef_impact_day_w1 if emg==1
mean coef_impact_w1 if china==1
mean coef_impact_w1 if before_event==1
mean coef_impact_w1 if EC==1
mean coef_impact_w1 if around_ev_==1
mean coef_impact_w1 if after_event==1
mean coef_impact_w1 if exotic_ew==1
mean coef_impact_w1 if confound_event_y==1
mean coef_impact_w1 if mkt_model==1
mean coef_impact_w1 if mkt_model==0
mean coef_impact_w1 if reputational_estimate==1
mean coef_impact_w1 if cross_sectional_reg==1
mean coef_impact_w1 if ref_journal==1
mean coef_impact_w1 if ref_journal==0
*Weithed means, by the inv of the nb of estimates per study
mean coef_impact_w1 [aweight=invnobs]
mean coef_impact_w1 [aweight=invnobs] if only_account==1
mean coef_impact_w1 [aweight=invnobs] if only_reg_secur_laws==1
mean coef_impact_w1 [aweight=invnobs] if reg_secur_laws_incl_account==1
mean coef_impact_w1 [aweight=invnobs] if regulatory_proc==1
mean coef_impact_w1 [aweight=invnobs] if priv_enforcement==1
mean coef_impact_w1 [aweight=invnobs] if alleged_fraud==1
mean coef_impact_w1 [aweight=invnobs] if alleged_fraud==0
mean coef_impact_w1 [aweight=invnobs] if source_press==1
mean coef_impact_w1 [aweight=invnobs] if source_firm==1
mean coef_impact_w1 [aweight=invnobs] if source_reg==1
mean coef_impact_w1 [aweight=invnobs] if only_usa==1
mean coef_impact_w1 [aweight=invnobs] if common_law==1
mean coef_impact_w1 [aweight=invnobs] if common_law==0
mean coef_impact_w1 [aweight=invnobs] if emg==1
mean coef_impact_w1 [aweight=invnobs] if china==1
mean coef_impact_w1 [aweight=invnobs] if before_event==1
mean coef_impact_w1 [aweight=invnobs] if EC==1
mean coef_impact_w1 [aweight=invnobs] if around_ev_==1
mean coef_impact_w1 [aweight=invnobs] if after_event==1
mean coef_impact_w1 [aweight=invnobs] if exotic_ew==1
mean coef_impact_w1 [aweight=invnobs] if confound_event_y==1
mean coef_impact_w1 [aweight=invnobs] if mkt_model==1
mean coef_impact_w1 [aweight=invnobs] if mkt_model==0
mean coef_impact_w1 [aweight=invnobs] if reputational_estimate==1
mean coef_impact_w1 [aweight=invnobs] if cross_sectional_reg==1
mean coef_impact_w1 [aweight=invnobs] if ref_journal==1
mean coef_impact_w1 [aweight=invnobs] if ref_journal==0
******************************************************************************
*Table 1-B: AARDs and winsorized
*Simple avg
mean coef_impact_day_w1
mean coef_impact_day_w1 if only_account==1
mean coef_impact_day_w1 if only_reg_secur_laws==1
mean coef_impact_day_w1 if reg_secur_laws_incl_account==1
mean coef_impact_day_w1 if regulatory_proc==1
mean coef_impact_day_w1 if priv_enforcement==1
mean coef_impact_day_w1 if alleged_fraud==1
mean coef_impact_day_w1 if alleged_fraud==0
mean coef_impact_day_w1 if source_press==1
mean coef_impact_day_w1 if source_firm==1
mean coef_impact_day_w1 if source_reg==1
mean coef_impact_day_w1 if only_usa==1
mean coef_impact_day_w1 if common_law==1
mean coef_impact_day_w1 if common_law==0
mean coef_impact_day_w1 if emg==1
mean coef_impact_day_w1 if china==1
mean coef_impact_day_w1 if before_event==1
mean coef_impact_day_w1 if EC==1
mean coef_impact_day_w1 if around_ev_==1
mean coef_impact_day_w1 if after_event==1
mean coef_impact_day_w1 if exotic_ew==1
mean coef_impact_day_w1 if confound_event_y==1
mean coef_impact_day_w1 if mkt_model==1
mean coef_impact_day_w1 if mkt_model==0
mean coef_impact_day_w1 if reputational_estimate==1
mean coef_impact_day_w1 if cross_sectional_reg==1
mean coef_impact_day_w1 if ref_journal==1
mean coef_impact_day_w1 if ref_journal==0
*Weithed means, by the inv of the nb of estimates per study
mean coef_impact_day_w1 [aweight=invnobs]
mean coef_impact_day_w1 [aweight=invnobs] if only_account==1
mean coef_impact_day_w1 [aweight=invnobs] if only_reg_secur_laws==1
mean coef_impact_day_w1 [aweight=invnobs] if reg_secur_laws_incl_account==1
mean coef_impact_day_w1 [aweight=invnobs] if regulatory_proc==1
mean coef_impact_day_w1 [aweight=invnobs] if priv_enforcement==1
mean coef_impact_day_w1 [aweight=invnobs] if alleged_fraud==1
mean coef_impact_day_w1 [aweight=invnobs] if alleged_fraud==0
mean coef_impact_day_w1 [aweight=invnobs] if source_press==1
mean coef_impact_day_w1 [aweight=invnobs] if source_firm==1
mean coef_impact_day_w1 [aweight=invnobs] if source_reg==1
mean coef_impact_day_w1 [aweight=invnobs] if only_usa==1
mean coef_impact_day_w1 [aweight=invnobs] if common_law==1
mean coef_impact_day_w1 [aweight=invnobs] if common_law==0
mean coef_impact_day_w1 [aweight=invnobs] if emg==1
mean coef_impact_day_w1 [aweight=invnobs] if china==1
mean coef_impact_day_w1 [aweight=invnobs] if before_event==1
mean coef_impact_day_w1 [aweight=invnobs] if EC==1
mean coef_impact_day_w1 [aweight=invnobs] if around_ev_==1
mean coef_impact_day_w1 [aweight=invnobs] if after_event==1
mean coef_impact_day_w1 [aweight=invnobs] if exotic_ew==1
mean coef_impact_day_w1 [aweight=invnobs] if confound_event_y==1
mean coef_impact_day_w1 [aweight=invnobs] if mkt_model==1
mean coef_impact_day_w1 [aweight=invnobs] if mkt_model==0
mean coef_impact_day_w1 [aweight=invnobs] if reputational_estimate==1
mean coef_impact_day_w1 [aweight=invnobs] if cross_sectional_reg==1
mean coef_impact_day_w1 [aweight=invnobs] if ref_journal==1
mean coef_impact_day_w1 [aweight=invnobs] if ref_journal==0
******************************************************************************

*CALCULATIONS FOR TABLE A.1 (appendix)
sum coef_impact_w1
mean coef_impact_w1 [aweight=invnobs]
sum standard_error_wcs_w1
mean standard_error_wcs_w1 [aweight=invnobs]
sum coef_impact_day_w1
mean coef_impact_day_w1 [aweight=invnobs]
sum standard_error_wcs_day_w1
mean standard_error_wcs_day_w1 [aweight=invnobs]
*data characts
sum only1_country
mean only1_country [aweight=invnobs]
sum only_usa
mean only_usa [aweight=invnobs]
sum asia
mean asia [aweight=invnobs]
sum eu
mean eu [aweight=invnobs]
sum china
mean china [aweight=invnobs]
sum emg
mean emg [aweight=invnobs]
sum common_law
mean common_law [aweight=invnobs]
sum begining_period
mean begining_period [aweight=invnobs]
sum end_period
mean end_period [aweight=invnobs]
sum nb_years_data
mean nb_years_data [aweight=invnobs]
sum avg_year_data
mean avg_year_data [aweight=invnobs]
sum mid_point
mean mid_point [aweight=invnobs]
sum only_account
mean only_account [aweight=invnobs]
sum only_reg_secur_laws
mean only_reg_secur_laws [aweight=invnobs]
sum reg_secur_laws_incl_account
mean reg_secur_laws_incl_account [aweight=invnobs]
sum source_press
mean source_press [aweight=invnobs]
sum source_reg
mean source_reg [aweight=invnobs]
sum source_firm
mean source_firm [aweight=invnobs]
sum alleged_fraud
mean alleged_fraud [aweight=invnobs]
sum investigation
mean investigation [aweight=invnobs]
sum settlements
mean settlements [aweight=invnobs]
sum accounting_restatement
mean accounting_restatement [aweight=invnobs]
sum verdict_sanction
mean verdict_sanction [aweight=invnobs]
sum regulatory_proc
mean regulatory_proc [aweight=invnobs]
sum stock_mkt_proc
mean stock_mkt_proc [aweight=invnobs]
sum class_action
mean class_action [aweight=invnobs]
sum lawsuits
mean lawsuits [aweight=invnobs]
*Estimation characteristics:
sum mkt_model
mean mkt_model [aweight=invnobs]
sum mkt_index_val_weight
mean mkt_index_val_weight [aweight=invnobs]
sum source_crsp
mean source_crsp [aweight=invnobs]
sum nb_ests_perstudy
mean nb_ests_perstudy [aweight=invnobs]
sum initial_sample_size_y
mean initial_sample_size_y [aweight=invnobs]
sum confound_event_y
mean confound_event_y [aweight=invnobs]
sum sample_size
mean sample_size [aweight=invnobs]
sum ln_sample_size
mean ln_sample_size [aweight=invnobs]
sum estimation_window_y
mean estimation_window_y [aweight=invnobs]
sum start_estim_w
mean start_estim_w [aweight=invnobs]
sum end_estim_w
mean end_estim_w [aweight=invnobs]
sum start_event_w
mean start_event_w [aweight=invnobs]
sum end_event_w
mean end_event_w [aweight=invnobs]
sum length_event_w
mean length_event_w [aweight=invnobs]
sum lt_caar
mean lt_caar [aweight=invnobs]
sum event_w_begin
mean event_w_begin [aweight=invnobs]
sum event_w_end
mean event_w_end [aweight=invnobs]
sum length_ev_wind
mean length_ev_wind [aweight=invnobs]
sum before_event
mean before_event [aweight=invnobs]
sum EC
mean EC [aweight=invnobs]
sum around_ev_
mean around_ev_ [aweight=invnobs]
sum after_event 
mean after_event  [aweight=invnobs]
sum exotic_ew
mean exotic_ew  [aweight=invnobs]
sum t_stat_wcs
mean t_stat_wcs [aweight=invnobs]
sum signif
mean signif [aweight=invnobs]
sum star_y
mean star_y [aweight=invnobs]
sum t_stat_y
mean t_stat_y [aweight=invnobs]
sum z_stat_y
mean z_stat_y [aweight=invnobs]
sum p_val_y
mean p_val_y [aweight=invnobs]
sum other_stat_y
mean other_stat_y [aweight=invnobs]
sum reputational_estimate
mean reputational_estimate [aweight=invnobs]
sum cross_sectional_reg
mean cross_sectional_reg [aweight=invnobs]
*Publication
sum nb_authors
mean nb_authors [aweight=invnobs]
sum authors_duplicate_stud
mean authors_duplicate_stud [aweight=invnobs]	 
sum year
mean year [aweight=invnobs]
sum month
mean month [aweight=invnobs]
sum ln_pub_year
mean ln_pub_year [aweight=invnobs]
sum account_journal
mean account_journal [aweight=invnobs]
sum finance_journal
mean finance_journal [aweight=invnobs]
sum law_journal
mean law_journal [aweight=invnobs]
sum business_journal
mean business_journal [aweight=invnobs]
sum cross_discipl
mean cross_discipl [aweight=invnobs]
sum ref_journal
mean ref_journal [aweight=invnobs]
sum scopus_journal_2018
mean scopus_journal_2018 [aweight=invnobs]
sum cite_score_year_2018
mean cite_score_year_2018 [aweight=invnobs]
sum cite_score_year_2011_18
mean cite_score_year_2011_18 [aweight=invnobs]
sum repec_journals_if_may2020
mean repec_journals_if_may2020 [aweight=invnobs]
sum nb_citations_google_scholar
mean nb_citations_google_scholar [aweight=invnobs]
sum citations
mean citations[aweight=invnobs]
*Control vars
sum log_nom_gdp
mean log_nom_gdp [aweight=invnobs]
sum log_gni_capita
mean log_gni_capita [aweight=invnobs]
sum log_gdp_capita
mean log_gdp_capita [aweight=invnobs]
sum mkt_cap_gdp
mean mkt_cap_gdp [aweight=invnobs]
sum mkt_liquidity
mean mkt_liquidity [aweight=invnobs]
sum log_list_firm_pop
mean log_list_firm_pop [aweight=invnobs]
sum traded_stks_gdp
mean traded_stks_gdp [aweight=invnobs]
sum creditgdp
mean creditgdp [aweight=invnobs]
sum rule_of_law
mean rule_of_law [aweight=invnobs]
sum fraser_regul
mean fraser_regul [aweight=invnobs]
sum fraser_regul_cred
mean fraser_regul_cred [aweight=invnobs]
sum main_sect_indus 
mean main_sect_indus [aweight=invnobs]
sum main_sect_financ
mean main_sect_financ [aweight=invnobs]
sum trust_wvs 
mean trust_wvs [aweight=invnobs]
sum conf_gov_wvs 
mean conf_gov_wvs [aweight=invnobs]
sum justice_wvs
mean justice_wvs[aweight=invnobs]

*****************************************************************************************
*PLOTS - HISTOGRAMS
****************************************************************************************

* Frequency distrib CAARs split by geo
*Fig 2.a: AAR+CAAR
twoway (hist coef_impact_w1 if only_usa==1 & coef_impact_w1>-0.4 & coef_impact_w1<0.1, freq width(0.025) lcolor(black) fcolor(gs12) legend(label(1 "U.S."))) (hist coef_impact_w1 if only_usa==0 & coef_impact_w1>-0.4 & coef_impact_w1<0.1, freq width(0.025) fcolor(white) lcolor(black) legend(label(2 "Non U.S. countries"))) , ytitle("Frequency distrib. of AARs and CAARs, by geo.") xtitle("Estimates of the AARs and CAARs") xline(0, lpattern(solid) lw(medthick) lcolor(black)) xline(-0.0653, lpattern(dot) lcolor (grey) lw(medthin)) xline(-0.01740, lpattern(dash) lcolor (black) lw(medthin)) saving(freq_AAR_CAAR_US_nonUS, replace)
*Fig 2.a: AARD
twoway (hist coef_impact_day_w1 if only_usa==1 & coef_impact_day_w1>-0.15 & coef_impact_day_w1<0.05, freq width(0.01) lcolor(black) fcolor(gs12) legend(label(1 "U.S."))) (hist coef_impact_day_w1 if only_usa==0 & coef_impact_day_w1>-0.15 & coef_impact_day_w1<0.05, freq width(0.01) fcolor(white) lcolor(black) legend(label(2 "Non U.S. countries"))) , ytitle("Frequency distrib. of AARDs, by geo.") xtitle("Estimates of the AARDs") xline(0, lpattern(solid) lw(medthick) lcolor(black)) xline(-0.0246, lpattern(dot) lcolor (grey) lw(medthin)) xline(-0.0067, lpattern(dash) lcolor (black) lw(medthin)) saving(freq_AARD_US_nonUS, replace)

* Frequency distrib CAARs split by crimes
*Fig 2.b:: AAR+CAAR
twoway  (hist coef_impact if only_account==0 & coef_impact>-0.4 & coef_impact<0.1, freq width(0.025) fcolor(white) lcolor(black) legend(label(2 "Violations of securities laws"))) (hist coef_impact if only_account==1 & coef_impact>-0.4 & coef_impact<0.1, freq width(0.025) lcolor(black) fcolor(gs12) legend(label(1 "Accounting frauds"))), ytitle("Frequency distrib. of AARs and CAARs, by crimes") xtitle("Estimates of the AARs and CAARs") xline(0, lpattern(solid) lw(medthick) lcolor(black)) xline(-0.0691, lpattern(dot) lcolor (grey) lw(medthin)) xline(-0.038, lpattern(dash) lcolor (black) lw(medthin)) saving(freq_AAR_CAAR_acc, replace)
*Fig 2.b:: AARD
twoway (hist coef_impact_day if only_account==0 & coef_impact_day>-0.15 & coef_impact_day<0.05, freq width(0.01) fcolor(white) lcolor(black) legend(label(2 "Violations of securities laws"))) (hist coef_impact_day if only_account==1 & coef_impact_day>-0.15 & coef_impact_day<0.05, freq width(0.01) lcolor(black) fcolor(gs12) legend(label(1 "Accounting frauds"))) , ytitle("Frequency distrib. of AARDs, by crimes") xtitle("Estimates of the AARDs") xline(0, lpattern(solid) lw(medthick) lcolor(black)) xline(-0.0284, lpattern(dot) lcolor (grey) lw(medthin)) xline(-0.0133 , lpattern(dash) lcolor (black) lw(medthin)) saving(freq_AARD_acc, replace)

* Frequency distrib AARDs NOT split by geo
*Figure 5-A
histogram t_stat_wcs if t_stat_wcs>-20, xline(-1.82, lcolor(gs12)) xline(-2.58, lcolor(gs08)) width(0.5) frequency xtitle("Reported t-statistic (worst case scenario)") saving(histogram_tstat2, replace) 
*Fig 5-B: kernel density
kdensity t_stat_wcs

* GRAPH TIME TREND (FIG 3 B)
graph twoway (scatter coef_impact_day_med midyear_med, msize(*1) msymbol(Oh)) (lfit coef_impact_day midyear_med, lcolor(black)),  xtitle("Median year of data") ytitle("Median estimate of the AARDs") legend(off) saving(trend, replace)
* GRAPH TIME TREND (FIG 3 A)
graph twoway (scatter coef_impact_med midyear_med, msize(*1) msymbol(Oh)) (lfit coef_impact_day midyear_med, lcolor(black)),  xtitle("Median year of data") ytitle("Median estimate of the AARs and CAARs") legend(off) saving(trend, replace)

*boxplot of all studies
graph hbox coef_impact_day, over(authors, label(grid) sort(midyear_med)) xsize(16) ysize(20) scale(0.25) yline(-0.0182, lcolor(gs12)) box( 1,lcolor(black)) marker(1,msymbol(circle_hollow)  mcolor(gs12)) ytitle("Average abnormal per day (AARDs)") ylabel(, nogrid) saving(studies, replace)
graph hbox coef_impact, over(authors, label(grid) sort(midyear_med)) xsize(16) ysize(20) scale(0.25) yline(-0.0489925, lcolor(gs12)) box( 1,lcolor(black)) marker(1,msymbol(circle_hollow)  mcolor(gs12)) ytitle("Average Abnormal Returns (AARs and CAARs)") ylabel(, nogrid) saving(studies2, replace)

******************************************************************************
* Funnel plot
******************************************************************************

gen invse_day=1/standard_error_wcs_day
gen invse_day_w1=1/standard_error_wcs_day_w1
gen invse=1/standard_error_wcs
gen invse_w1=1/standard_error_wcs_w1
gen invse2_w1=1/(standard_error_wcs_day_w1*standard_error_wcs_day_w1)

*Figure 4 A
graph twoway scatter invse coef_impact if coef_impact>-0.4 & coef_impact<0.1, ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of AARs and CAARs")  xline(0, lpattern(dott) lcolor (grey)) saving(funnel_AAR_CAAR, replace)
graph twoway scatter invse_day coef_impact_day if coef_impact_day>-0.15 & coef_impact_day<0.05, ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of AARDs")  xline(0, lpattern(dott) lcolor (grey)) saving(funnel_AARD, replace)

*US versus non US
*Figure 4 B
graph twoway (scatter invse coef_impact if only_usa==0 & coef_impact>-0.4 & coef_impact<0.1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse coef_impact if only_usa==1 & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARs and CAARs") xline(0, lpattern(dott) lcolor (black)) saving(funnel_both2, replace)
graph twoway (scatter invse_day coef_impact_day if only_usa==0 & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse_day coef_impact_day if only_usa==1 & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs") xline(0, lpattern(dott) lcolor (black)) saving(funnel_US_AARD, replace)

*Only US and alleged versus condemned // RDM alleged versus condemned
* Figure F
graph twoway (scatter invse coef_impact if only_usa==1 & coef_impact>-0.4 & coef_impact_day<0.1 & alleged==1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse coef_impact_day if only_usa==1 & coef_impact_day>-0.4 & coef_impact_day<0.1 & alleged==0, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of the AARs and CAARs in the U.S.") xline(0, lpattern(dott) lcolor (black)) saving(funnel_CAAR_US_alleged, replace)
graph twoway (scatter invse coef_impact if only_usa==0 & coef_impact>-0.4 & coef_impact_day<0.1 & alleged==1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse coef_impact_day if only_usa==0 & coef_impact_day>-0.4 & coef_impact_day<0.1 & alleged==0, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of the AARs and CAARs in other countries") xline(0, lpattern(dott) lcolor (black)) saving(funnel_CAAR_nonUS_alleged, replace)

graph twoway (scatter invse_day coef_impact_day if only_usa==1 & coef_impact_day>-0.15 & coef_impact_day<0.05 & alleged==1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse_day coef_impact_day if only_usa==1 & coef_impact_day>-0.15 & coef_impact_day<0.05 & alleged==0, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of the AARDs in the U.S.") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_US_alleged, replace)
graph twoway (scatter invse_day coef_impact_day if only_usa==0 & coef_impact_day>-0.15 & coef_impact_day<0.05 & alleged==1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse_day coef_impact_day if only_usa==0 & coef_impact_day>-0.15 & coef_impact_day<0.05 & alleged==0, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimate of the AARDs in other countries") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_US_alleged, replace)


*Accounting versus other violations
*Figure 4 C
graph twoway (scatter invse coef_impact if only_account==0 & coef_impact>-0.4 & coef_impact<0.1, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse coef_impact if only_account==1 & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARs and CAARs") xline(0, lpattern(dott) lcolor (black)) saving(funnel_both_AAR_account, replace)
graph twoway (scatter invse_day coef_impact_day if only_account==0 & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*1) msymbol(Oh) mcolor(grey) ) (scatter invse_day coef_impact_day if only_account==1 & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black)) , ytitle("Precision of the estimates (1/SE)") xtitle("Estimate of the AARDs") xline(0, lpattern(dott) lcolor (black)) saving(funnel_both_AARD_account2, replace)

*Funnel plots by event windows 
*AARs & CAARs
graph twoway (scatter invse coef_impact if caar=="CAAR[-1;+1]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the CAARDs for the event window [-1;+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_CAAR[-1;+1], replace)
graph twoway (scatter invse coef_impact if caar=="AAR[0]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARs (or AARDs) for the event window [0]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_AAR[0], replace)
graph twoway (scatter invse coef_impact if caar=="AAR[-1]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARs (or AARDs) for the event window [-1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_AAR[-1], replace)
graph twoway (scatter invse coef_impact if caar=="AAR[+1]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARs (or AARDs) for the event window [+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_AAR[+1], replace)
graph twoway (scatter invse coef_impact if caar=="CAAR[-1;0]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the CAARs for the event window [-1;0]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_CAAR[-1;0], replace)
graph twoway (scatter invse coef_impact if caar=="CAAR[0;+1]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the CAARs for the event window [0;+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_CAAR[0;+1], replace)
graph twoway (scatter invse coef_impact if caar=="CAAR[-2;+2]" & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the CAARs for the event window [-2;+2]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_CAAR[-2;+2], replace)
graph twoway (scatter invse coef_impact if exotic_ew==1 & coef_impact>-0.4 & coef_impact<0.1, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the CAARs for exotic event windows") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AAR_exotic, replace)
*AARDs
graph twoway (scatter invse_day coef_impact_day if caar=="CAAR[-1;+1]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [-1;+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_CAAR[-1;+1], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="AAR[0]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [0]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_AAR[0], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="AAR[-1]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [-1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_AAR[-1], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="AAR[+1]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_AAR[+1], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="CAAR[-1;0]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [-1;0]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_CAAR[-1;0], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="CAAR[0;+1]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [0;+1]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_CAAR[0;+1], replace)
graph twoway (scatter invse_day coef_impact_day if caar=="CAAR[-2;+2]" & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for the event window [-2;+2]") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_CAAR[-2;+2], replace)
graph twoway (scatter invse_day coef_impact_day if exotic_ew==1 & coef_impact_day>-0.15 & coef_impact_day<0.05, msize(*0.5) msymbol(O) mcolor(black) ) , ytitle("Precision of the estimate (1/SE)") xtitle("Estimates of the AARDs for exotic event windows") xline(0, lpattern(dott) lcolor (black)) saving(funnel_AARD_exotic, replace)

******************************************************************************
******************************************************************************
* PUBLICATION BIAS - FULL SAMPLE: CAARs & AARs - WINSOR 1%
******************************************************************************
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 , cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if only_usa==1, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if only_usa==0, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if only_account==1, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if only_account==0, cluster(idstudy)
esttab using table_bias_ALL_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1, fe 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_usa==1, fe 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_usa==0 , fe 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_account==1, fe 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_account==0 , fe 
esttab using table_bias_ALL_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1, be 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_usa==1, be 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_usa==0, be 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_account==1, be 
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if only_account==0, be 
esttab using table_bias_ALL_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV Final
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years), cluster(idstudy) 
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if only_usa==1, cluster(idstudy) 
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if only_usa==0, cluster(idstudy) 
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if only_account==1, cluster(idstudy) 
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if only_account==0, cluster(idstudy) 
esttab using table_bias_ALL_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invnobs], cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invnobs] if only_usa==1, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invnobs] if only_usa==0, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invnobs] if only_account==1, cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invnobs] if only_account==0, cluster(idstudy)
esttab using table_bias_ALL_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invse_w1],cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invse_w1] if only_usa==1,cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invse_w1] if only_usa==0,cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invse_w1] if only_account==1,cluster(idstudy)
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 [pweight=invse_w1] if only_account==0,cluster(idstudy)
esttab using table_bias_ALL_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_w1, noconstant
eststo: reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0058648/2.8, noconstant cluster(idstudy)
eststo: reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0058648/2.8 & only_usa==1, noconstant cluster(idstudy)
eststo: reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0058648/2.8 & only_usa==0, noconstant cluster(idstudy)
eststo: reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.00558648/2.8 & only_account==1, noconstant cluster(idstudy)
eststo: reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0058648/2.8 & only_account==0, noconstant cluster(idstudy)
esttab using table_bias_ALL_waap.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear

******************************************************************************
******************************************************************************
* PUBLICATION BIAS - FAT-PET - SPLIT USA VERSUS RDM
* FULL SAMPLE: AARDs WINZOR 1%
******************************************************************************
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1, cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==1,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==0, cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==1,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==0, cluster(idstudy)
esttab using table_bias_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1, fe 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==1, fe 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==0, fe 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==1, fe 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==0, fe 
esttab using table_bias_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1, be 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==1, be 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==0, be 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==1, be 
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==0, be 
esttab using table_bias_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV 
gen lnobs=ln(sample_size)
gen years=ln(nb_years_data)
gen csunit2=ln(sample_size/length_ev_wind)
eststo: ivreg2 coef_impact_day_w1 (standard_error_wcs_day_w1=lnobs csunit2 years), cluster(idstudy) 
eststo: ivreg2 coef_impact_day_w1 (standard_error_wcs_day_w1=lnobs csunit2 years) if only_usa==1, cluster(idstudy) 
eststo: ivreg2 coef_impact_day_w1 (standard_error_wcs_day_w1=lnobs csunit2 years) if only_usa==0, cluster(idstudy) 
eststo: ivreg2 coef_impact_day_w1 (standard_error_wcs_day_w1=lnobs csunit2 years) if only_account==1, cluster(idstudy) 
eststo: ivreg2 coef_impact_day_w1 (standard_error_wcs_day_w1=lnobs csunit2 years) if only_account==0, cluster(idstudy) 
esttab using table_bias_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 [pweight=invnobs], cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==1 [pweight=invnobs_usa],  cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==0 [pweight=invnobs_non_usa], cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==1 [pweight=invnobs_acc],  cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==0 [pweight=invnobs_non_acc], cluster(idstudy)
esttab using table_bias_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 [pweight=invse_day_w1],cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==1 [pweight=invse_day_w1], cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_usa==0 [pweight=invse_day_w1], cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==1 [pweight=invse_day_w1], cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 if only_account==0 [pweight=invse_day_w1], cluster(idstudy)
esttab using table_bias_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_day_w1, noconstant
reg t_stat_wcs_w1 invse_day_w1 if standard_error_wcs_day_w1<0.0027967/2.8, noconstant cluster(idstudy)
reg t_stat_wcs_w1 invse_day_w1 if standard_error_wcs_day_w1<0.0027967/2.8 & only_usa==1, noconstant cluster(idstudy)
reg t_stat_wcs_w1 invse_day_w1 if standard_error_wcs_day_w1<0.0027967/2.8 & only_usa==0, noconstant cluster(idstudy)
reg t_stat_wcs_w1 invse_day_w1 if standard_error_wcs_day_w1<0.0027967/2.8 & only_account==1, noconstant cluster(idstudy)
reg t_stat_wcs_w1 invse_day_w1 if standard_error_wcs_day_w1<0.0027967/2.8 & only_account==0, noconstant cluster(idstudy)

******************************************************************************
* PUBLICATION BIAS - CAAR[-1;+1]
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==+1, cluster(idstudy)
esttab using table_bias_AAR11_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects, without cluster as in Havranek (2020 a and b)
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==+1, fe 
esttab using table_bias_AAR11_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==+1, be 
esttab using table_bias_AAR11_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV Final
gen lnobs=ln(sample_size)
gen years=ln(nb_years_data)
gen csunit2=ln(sample_size/length_ev_wind)
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if event_w_begin==-1 & event_w_end==+1 , cluster(idstudy) 
esttab using table_bias_AAR11_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==+1 [pweight=invnobs], cluster(idstudy)
esttab using table_bias_AAR11_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==1 [pweight=invse_w1],cluster(idstudy)
esttab using table_bias_AAR11_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_w1 if event_w_begin==-1 & event_w_end==+1, noconstant
reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0119481/2.8 & event_w_begin==-1 & event_w_end==+1, noconstant cluster(idstudy)
eststo clear

******************************************************************************
* PUBLICATION BIAS - AAR[0]
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==0 & event_w_end==0, cluster(idstudy)
esttab using table_bias_AAR0_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==0 & event_w_end==0, fe 
esttab using table_bias_AAR0_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==0 & event_w_end==0, be 
esttab using table_bias_AAR0_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV Final
gen lnobs=ln(sample_size)
gen years=ln(nb_years_data)
gen csunit2=ln(sample_size/length_ev_wind)
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if event_w_begin==0 & event_w_end==0, cluster(idstudy) 
esttab using table_bias_AAR0_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==0 & event_w_end==0 [pweight=invnobs], cluster(idstudy)
esttab using table_bias_AAR0_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==0 & event_w_end==0 [pweight=invse_w1],cluster(idstudy)
esttab using table_bias_AAR0_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_w1 if event_w_begin==0 & event_w_end==0, noconstant
reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0053025/2.8 & event_w_begin==0 & event_w_end==0, noconstant cluster(idstudy)
eststo clear

******************************************************************************
* PUBLICATION BIAS - AAR[-1]
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==-1, cluster(idstudy)
esttab using table_bias_AAR-1_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==-1, fe 
esttab using table_bias_AAR-1_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==-1, be 
esttab using table_bias_AAR-1_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV Final
gen lnobs=ln(sample_size)
gen years=ln(nb_years_data)
gen csunit2=ln(sample_size/length_ev_wind)
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if event_w_begin==-1 & event_w_end==-1, cluster(idstudy) 
esttab using table_bias_AAR-1_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==-1 [pweight=invnobs], cluster(idstudy)
esttab using table_bias_AAR-1_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==-1 & event_w_end==-1 [pweight=invse_w1],cluster(idstudy)
esttab using table_bias_AAR-1_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_w1 if event_w_begin==-1 & event_w_end==-1, noconstant
reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0020961/2.8 & event_w_begin==0 & event_w_end==0, noconstant cluster(idstudy)
eststo clear

******************************************************************************
* PUBLICATION BIAS - AAR[+1]
******************************************************************************
xtset idstudy
*OLS
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==1 & event_w_end==1, cluster(idstudy)
esttab using table_bias_AAR1_ols.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Fixed effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==1 & event_w_end==1, fe 
esttab using table_bias_AAR1_fe.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Between effects
eststo: xtreg coef_impact_w1 standard_error_wcs_w1 if event_w_begin==1 & event_w_end==1, be 
esttab using table_bias_AAR1_be.tex, se booktabs replace compress title(FAT-PET between effect\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*IV Final
gen lnobs=ln(sample_size)
gen years=ln(nb_years_data)
gen csunit2=ln(sample_size/length_ev_wind)
eststo: ivreg2 coef_impact_w1 (standard_error_wcs_w1=lnobs csunit2 years) if event_w_begin==1 & event_w_end==1, cluster(idstudy) 
esttab using table_bias_AAR1_iv_koc2.tex, se booktabs replace compress title(FAT-PET IV\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the nb of estimates reported by study
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==1 & event_w_end==1 [pweight=invnobs], cluster(idstudy)
esttab using table_bias_AAR1_nobs.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
*Weighted by the inverse of the standard error 
eststo: ivreg2 coef_impact_w1 standard_error_wcs_w1 if event_w_begin==1 & event_w_end==1 [pweight=invse_w1],cluster(idstudy)
esttab using table_bias_AAR1_se1.tex, se booktabs replace compress title(FAT-PET all\label{tab:fatpet}) star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01)
eststo clear
* PUBLICATION BIAS - WAAP (Ioannidis et al., 2017) 
reg t_stat_wcs_w1 invse_w1 if event_w_begin==1 & event_w_end==1, noconstant
reg t_stat_wcs_w1 invse_w1 if standard_error_wcs_w1<0.0034801/2.8 & event_w_begin==1 & event_w_end==1, noconstant cluster(idstudy)
eststo clear

******************************************************************************
* PUBLICATION BIAS - checking dependence on study design
* Endogeneity
******************************************************************************
***1/ Sample characteristics
******************************************************************************
gen ln_google=ln(1+nb_citations_google_scholar/(2020-year+1))
*U.S. 
gen se_usa = standard_error_wcs_day_w1 * only_usa
*accounting frauds 
gen se_account = standard_error_wcs_day_w1 * only_account
*source: firm
gen se_firm = standard_error_wcs_day_w1 * source_firm

***2/ Publication characteristics
******************************************************************************
*google
gen se_google = standard_error_wcs_day_w1 * ln_google
*scopus cite score
gen se_scopus = standard_error_wcs_day_w1*cite_score_year_2018

*Reg 
******************************************************************************
xtset idstudy
xtreg coef_impact_day_w1 standard_error_wcs_day_w1, fe cluster (idstudy)
***1/ Sample characteristics
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_usa only_usa, fe cluster (idstudy)
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_account only_account, fe cluster (idstudy)
*eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_alleged alleged_fraud, fe cluster (idstudy)
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_firm source_firm, fe cluster (idstudy)
***2/ Publication characteristics
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_google ln_google, fe cluster (idstudy)
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_scopus cite_score_year_2018, fe cluster (idstudy)
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_google ln_google se_scopus cite_score_year_2018, fe cluster (idstudy)
***3/ All characteristics
eststo: xtreg coef_impact_day_w1 standard_error_wcs_day_w1 se_usa only_usa se_account only_account se_firm source_firm se_google ln_google se_scopus cite_score_year_2018, fe cluster (idstudy)
esttab using "dependence.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("ident" "aggreg_inp" "aggreg_out" "inventory" "tlog" "short" "all") addnote("Standard errors are clustered at the study and country level.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

******************************************************************************
*IMPLIED AARDs as in Bajzik et al. (2020)
* Tab 5
******************************************************************************
*creation of variables "confidence" based on quality of the event study and the outlet (stricter that ref_journal). Confidence=0 for High confidence;  confidence=1 for low confidence
*1/ Quality of an event study = exclusion of confounding events + not exotic event window 
gen only_star=0
replace only_star=1 if star_y==1 & t_stat_y==0 & z_stat_y==0 & p_val_y==0 & initial_sample_size_y==1
gen quality_ev_std=0
replace quality_ev_std=1 if estimation_window_y==1 & z_stat_y==1

*2/ quality of publication: medium = published in a peer reviewed review; high = 7.34 (max)- 1.890530882 (std dev))
gen medium_quality=0
replace medium_quality=1 if ref_journal==1
gen high_quality_pub=0
replace high_quality_pub=1 if repec_journals_if_may2020>0.779

*a/ confidence 1 = high_quality_pub=1 & quality_ev_std=1
gen conf1=1
replace conf1=0 if high_quality_pub==1 & quality_ev_std==1
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1, cluster(idstudy)

*b/ confidence 2 = high_quality_pub=1 & relaxed condition on quality_ev_std
gen conf2=1
replace conf2=0 if high_quality_pub==1 
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf2, cluster(idstudy)

*c/ confidence 3 = medium_quality=1 & quality_ev_std=1
gen conf3=1
replace conf3=0 if medium_quality==1 & quality_ev_std==1
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf3, cluster(idstudy)

*d/ confidence 4 = medium_quality=1 & relaxed condition on quality_ev_std
gen conf4=1
replace conf4=0 if medium_quality==1 
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf4, cluster(idstudy)

esttab using "confidence.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("conf1" "conf2" "conf3" "conf4") addnote("Standard errors are clustered at the study.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

* Split by geography
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if only_usa==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf2 if common_law==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf2 if eu==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf2 if emg==1 ,cluster(idstudy)
esttab using "confidence_country.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("US" "Common Law" "EU" "EMG") addnote("Standard errors are clustered at the study.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

*Split by crimes: source_press source_firm source_reg alleged_fraud regulatory_proc
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if only_account==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if only_account==0 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if regulatory_proc==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if regulatory_proc==0 ,cluster(idstudy)
esttab using "confidence_crimes.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("Excl. accounting" "Other crimes" "Regulatory procedures" "Other procedures") addnote("Standard errors are clustered at the study.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

*split by sanctions
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if alleged_fraud==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if alleged_fraud==0 ,cluster(idstudy)
esttab using "confidence_sanction.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("alleged" "sanctioned") addnote("Standard errors are clustered at the study.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

*split by event study methodo
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if exotic_ew==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if exotic_ew==0,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf2 if only_star==1 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if only_star==0,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if confound_event_y==0 ,cluster(idstudy)
eststo: ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 conf1 if confound_event_y==1,cluster(idstudy)
esttab using "confidence_ev_std.tex", se booktabs replace compress title(Funnel asymmetry test\label{tab:fat}) mtitles("exotic ew" "not exotic ew" "Only stars" "Any other signif indicators" "Confound. ev. not excluded" "Confound. ev. excl.") addnote("Standard errors are clustered at the study.") star(\sym{*} 0.10 \sym{**} 0.05 \sym{***} 0.01) label nonumber nogaps width(1\hsize)
eststo clear

drop medium_quality only_star quality_ev_std high_quality_pub conf1 conf2 conf3 conf4

******************************************************************************
*HEDGES' TEST FOR PUBLICATION BIAS
******************************************************************************
global t1=invnormal(1-.5*.01)
global t2=invnormal(1-.5*.05)
global t3=invnormal(1-.5*.10)
dis %8.3f $t1 %8.3f $t2 %8.3f $t3

gen group=1
replace group=2 if t_stat_wcs<$t1
replace group=3 if t_stat_wcs<$t2
replace group=4 if t_stat_wcs<$t3

program hedges1
         version 14.1
         args todo b lnf
         tempvar theta1 sigma l eta
         mleval `theta1' = `b', eq(1)
         mleval `sigma'=`b', eq(2)

         gen double `eta'=sqrt(standard_error_wcs*standard_error_wcs+`sigma'*`sigma')

         quietly gen double `l' = -ln(`eta')-.5*(($ML_y1-`theta1')/`eta')^2
         mlsum `lnf' = `l'
end

program hedges2
         version 14.1
         args todo b lnf
         tempvar theta1 sigma l lg lgg g1 g2 g3 g4 eta
         mleval `theta1' = `b', eq(1)
         mleval `sigma'=`b', eq(2)
         mleval `g2'=`b', eq(3)
         mleval `g3'=`b', eq(4)
         mleval `g4'=`b', eq(5)

         gen double `eta'=sqrt(se*se+`sigma'*`sigma')
         gen double `g1'=1
         quietly gen double `lg'=`g1' if group==1
         quietly replace `lg'=(1-`g2') if group==2
         quietly replace `lg'=(1-`g3') if group==3
         quietly replace `lg'=(1-`g4') if group==4
         quietly gen double `lgg'=`g1'*(1-normal(($t1*se-`theta1')/`eta'))
         quietly replace `lgg'=`lgg'+(1-`g2')*(normal(($t1*standard_error_wcs-`theta1')/`eta')-normal(($t2*standard_error_wcs-`theta1')/`eta'))
         quietly replace `lgg'=`lgg'+(1-`g3')*(normal(($t2*standard_error_wcs-`theta1')/`eta')-normal(($t3*standard_error_wcs-`theta1')/`eta'))
         quietly replace `lgg'=`lgg'+(1-`g4')*(normal(($t3*standard_error_wcs-`theta1')/`eta'))
         quietly gen double `l' =-ln(`eta')-.5*(($ML_y1-`theta1')/`eta')^2+ln(`lg')-ln(`lgg')
         mlsum `lnf' = `l'
end

gen pubyear2=year-1984
gen nb_citations_google_scholar2=ln(nb_citations_google_scholar+1)

ml model d0 hedges1 (equation:coef_impact = ) (sigma:) 
ml maximize
gen ll1=e(ll)
ml model d0 hedges2 (equation:coef_impact = ) (sigma:)(g2:)(g3:)(g4:) 
ml maximize
gen ll2=e(ll)
ml model d0 hedges1 (equation:coef_impact = pubyear2 nb_citations_google_scholar2 scopus_journal_2018 cite_score_year_2011_18) (sigma:) 
ml maximize
gen ll5=e(ll)
ml model d0 hedges2 (equation:coef_impact_day = pubyear2 nb_citations_google_scholar2 scopus_journal_2018 cite_score_year_2011_18) (sigma:)(g2:)(g3:)(g4:) 
ml maximize
gen ll6=e(ll)
gen lldiff12=2*abs(ll1-ll2)
display lldiff12
display chi2tail(3, lldiff12)
gen lldiff56=2*abs(ll5-ll6)
display lldiff56
display chi2tail(3, lldiff56)
drop group ll1 ll2 ll5 ll6 lldiff12 lldiff56

*********************************************************************************
******************************************************************************
* HETEROGENEITY - OLS
******************************************************************************
******************************************************************************

ivreg2 coef_impact_day_w1 standard_error_wcs_day_w1 ln_sample_size	alleged_fraud	star_y	z_stat_y	cross_sectional_reg	nb_authors	cite_score_year_2018	citations	only_account	before_event	estimation_window_y	reputational_estimate EC	business_journal , cluster(idstudy )
reg coef_impact_day_w1 standard_error_wcs_day_w1 ln_sample_size	alleged_fraud	star_y	z_stat_y	cross_sectional_reg	nb_authors	cite_score_year_2018	citations	only_account	before_event	estimation_window_y	reputational_estimate EC	business_journal , cluster(idstudy )
estat vif
ovtest

* CORRELATION MATRIX
pwcorr only_usa mid_point only_account alleged_fraud source_firm initial_sample_size_y confound_event_y ln_sample_size estimation_window_y length_ev_wind before_event EC  exotic_ew star_y z_stat_y cross_sectional_reg reputational_estimate nb_authors authors_duplicate_stud business_journal citations cite_score_year_2018, sig star(0.05)

******************************************************************************
* PUBLICATION BIAS - FAT-PET (hierarchical Bayes) //// CODE for R ////
******************************************************************************

library(bayesm)
#http://www.perossi.org/home/bsm-1/bayesm
library(readxl)

setwd("D:/Documents/R/Meta_ana")
setwd("C:/Users/Laure de Batz/Documents/R/Meta_ana")
data_clean <- read_excel("data_clean_aar_caar_aard.xlsx")
#Data include AAR+CAAR and AARD + respective SEs
View(data_clean)

str(data_clean)#description of data in dataset 

#Full sample AARs+CAARs
#########################################################
study <- levels(as.factor(data_clean$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean$authors==study[i] 
  y <- data_clean$aar_w1[filter]
  X <- cbind(1,
             data_clean$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#Full sample AARDs
#########################################################
study <- levels(as.factor(data_clean$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean$authors==study[i] 
  y <- data_clean$aard_w1[filter]
  X <- cbind(1,
             data_clean$se_day_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#########################################################
#Full sample AARs+CAARs US versus RDM
#########################################################
#US
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_us.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aar_w1[filter]
  X <- cbind(1,
             data_clean11$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)
#########################################################
#non US
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_nonus.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aar_w1[filter]
  X <- cbind(1,
             data_clean11$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#########################################################
#Full sample AARs+CAARs account versus non account
#########################################################
#Accounting
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_acc.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aar_w1[filter]
  X <- cbind(1,
             data_clean11$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)
#########################################################
#non accounting
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_nonacc.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aar_w1[filter]
  X <- cbind(1,
             data_clean11$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)


#########################################################
#Full sample AARDs US versus RDM
#########################################################
#US
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_us.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aard_w1[filter]
  X <- cbind(1,
             data_clean11$se_day_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)
#########################################################
#non US
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_nonus.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aard_w1[filter]
  X <- cbind(1,
             data_clean11$se_day_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#########################################################
#Full sample AARDs account versus non account
#########################################################
#Accounting
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_acc.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aard_w1[filter]
  X <- cbind(1,
             data_clean11$se_day_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)
#########################################################
#non accounting
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar_aard_nonacc.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aard_w1[filter]
  X <- cbind(1,
             data_clean11$se_day_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#########################################################
#BY EVENT WINDOWS
#########################################################
#Full sample CAAR[-1;+1]
#########################################################
data_clean11 <- read_excel("data_clean_aar_caar11.xlsx")
study <- levels(as.factor(data_clean11$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean11$authors==study[i] 
  y <- data_clean11$aar_w1[filter]
  X <- cbind(1,
             data_clean11$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#Full sample AAR[0]
#########################################################
data_clean0 <- read_excel("data_clean_aar_aar0.xlsx")
study <- levels(as.factor(data_clean0$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean0$authors==study[i] 
  y <- data_clean0$aar_w1[filter]
  X <- cbind(1,
             data_clean0$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#Full sample AAR[-1]
#########################################################
data_cleanminus1 <- read_excel("data_clean_aar_aar_1.xlsx")
study <- levels(as.factor(data_cleanminus1$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_cleanminus1$authors==study[i] 
  y <- data_cleanminus1$aar_w1[filter]
  X <- cbind(1,
             data_cleanminus1$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

#Full sample AAR[+1]
#########################################################
data_clean1 <- read_excel("data_clean_aar_aar1.xlsx")
study <- levels(as.factor(data_clean1$authors))
nreg <- length(study); nreg
regdata <- NULL
for (i in 1:nreg) {
  filter <- data_clean1$authors==study[i] 
  y <- data_clean1$aar_w1[filter]
  X <- cbind(1,
             data_clean1$se_w1[filter])
  regdata[[i]] <- list(y=y, X=X) 
}
Data <- list(regdata=regdata) 
Mcmc <- list(R=6000)
out <- bayesm::rhierLinearModel( 
  Data=Data, 
  Mcmc=Mcmc)
cat("Summary of Delta Draws", fill=TRUE)
summary(out$Deltadraw)

******************************************************************************
******************************************************************************
* PUBLICATION BIAS - Stem-based method in R (Furukawa, 2019) ////CODE for R////
******************************************************************************
******************************************************************************
source("stem_method.R") #github.com/Chishio318/stem-based_method
library(view)

#Full sample CAAR and AAR
data_clean_median_caar <- read_excel("data_clean_median_caar.xlsx")
View(data_clean_median_caar)
stem_results = stem(data_clean_median_caar$caar, data_clean_median_caar$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median_caar$caar, data_clean_median_caar$se, stem_results$estimates)

#Full sample AARD
data_clean_median <- read_excel("data_clean_median.xlsx")
View(data_clean_median)
stem_results = stem(data_clean_median$aard, data_clean_median$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median$aard, data_clean_median$se, stem_results$estimates)

# AARD only US
data_clean_median <- read_excel("data_clean_median_aard_us.xlsx")
View(data_clean_median)
stem_results = stem(data_clean_median$aard, data_clean_median$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median$aard, data_clean_median$se, stem_results$estimates)

# AARD non US
data_clean_median <- read_excel("data_clean_median_aard_nonus.xlsx")
View(data_clean_median)
stem_results = stem(data_clean_median$aard, data_clean_median$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median$aard, data_clean_median$se, stem_results$estimates)

# AARD only accounting
data_clean_median <- read_excel("data_clean_median_aard_acc.xlsx")
View(data_clean_median)
stem_results = stem(data_clean_median$aard, data_clean_median$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median$aard, data_clean_median$se, stem_results$estimates)

# AARD not accounting
data_clean_median <- read_excel("data_clean_median_aard_nonacc.xlsx")
View(data_clean_median)
stem_results = stem(data_clean_median$aard, data_clean_median$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median$aard, data_clean_median$se, stem_results$estimates)

# CAAR[-1;+1]
data_clean_median_aar11 <- read_excel("data_clean_median_AAR11.xlsx")
View(data_clean_median_aar11)
stem_results = stem(data_clean_median_aar11$caar, data_clean_median_aar11$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median_aar11$caar, data_clean_median_aar11$se, stem_results$estimates)

# AAR[0]
data_clean_median_aar0 <- read_excel("data_clean_median_AAR0.xlsx")
View(data_clean_median_aar0)
stem_results = stem(data_clean_median_aar0$aar, data_clean_median_aar0$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median_aar0$aar, data_clean_median_aar0$se, stem_results$estimates)

# AAR[-1]
data_clean_median_aar_1 <- read_excel("data_clean_median_AAR_1.xlsx")
View(data_clean_median_aar_1)
stem_results = stem(data_clean_median_aar_1$aar, data_clean_median_aar_1$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median_aar_1$aar, data_clean_median_aar_1$se, stem_results$estimates)

# AAR[+1]
data_clean_median_aar1 <- read_excel("data_clean_median_AAR1.xlsx")
View(data_clean_median_aar1)
stem_results = stem(data_clean_median_aar1$aar, data_clean_median_aar1$se, param)
View(stem_results$estimates)
summary(stem_results$estimates)
stem_funnel (data_clean_median_aar1$aar, data_clean_median_aar1$se, stem_results$estimates)

******************************************************************************
******************************************************************************
* HETEROGENEITY - BAYESIAN MODEL AVERAGING ////CODE for R////
******************************************************************************
******************************************************************************
setwd("D:/_Backup/Documents/R/win-library/4.0)
install.packages("readxl")
setwd("D:/Documents/R/Meta_ana")
setwd("D:/Documents/R/win-library/4.0")
setwd("D:/Users/debl00/AppData/Local/Temp/Rtmpi8r1S9")
setwd("d:/Users/debl00/AppData/Local/Temp/Rtmpi8r1S9/downloaded_packages")

library(readxl)
library(BMS)
library(BH)
setwd("D:/Documents/R/Meta_ana")

data_clean2 <- read_excel("data_clean_5red.xlsx")
#data weighted by the inverse of the sqroot of the inverse of nb of estimates data_clean2 <- read_excel("data_clean_5red_nbest.xlsx")
#data weighted by he inverse of the SE per day w1  data_clean2 <- read_excel("data_clean_5red_invse.xlsx")

View(data_clean2)
str(data_clean2)
write.table(aard_w1,"BMA_aard.csv",sep=",")

aard_w1 = bms(data_clean2, burn=1e5,iter=3e5, g="UIP", mprior="uniform", nmodel=10000, mcmc="bd", user.int=FALSE) #as in all Havranek (2020)
coef(aard_w1, order.by.pip = T, exact=T, include.constant=T)
image(aard_w1, yprop2pip=F,  order.by.pip=TRUE, do.par=TRUE, do.grid=TRUE, do.axis=TRUE, cex.axis = 0.5)
*xlab="", main="",
summary(aard_w1)
plot(aard_w1)
print(aard_w1$topmod[1])
dev.off()

any(is.na(data_clean2))
any(is.infinite(data_clean2))

BMA_aard_w1_res<-coef(aard_w1, std.coefs=F, order.by.pip = T, exact=T,include.constant = T)
write.table(BMA_aard_w1_res,"BMA_baseline.csv", sep=" " )
image(BMA_aard_w1_res, cex=0.7, xlab="", main="")
summary(BMA_aard_w1_res)
plot(BMA_aard_w1_res)

aard1 = bms(data_clean2, burn=1e5,iter=3e5, g="UIP", mprior="dilut", nmodel=10000, mcmc="bd", user.int=FALSE) #central in graph & table Bajzik et al. (2020)
coef(aard1, order.by.pip = T, exact=T, include.constant=T)
image(aard1, yprop2pip=FALSE, order.by.pip=TRUE, do.par=TRUE, do.grid=TRUE, do.axis=TRUE, cex.axis = 0.5)
summary(aard1)

#robustness checks
#1/ weighted by the sqr root of inverse of nb estimates reported per study (nb_ests_perstudy)
data_clean2 <- read_excel("data_clean_5red_nbest.xlsx")
aard1 = bms(data_clean2, burn=1e5,iter=3e5, g="UIP", mprior="dilut", nmodel=10000, mcmc="bd", user.int=FALSE) #central in graph & table Bajzik et al. (2020)
coef(aard1, order.by.pip = T, exact=T, include.constant=T)
image(aard1, yprop2pip=FALSE, order.by.pip=TRUE, do.par=TRUE, do.grid=TRUE, xlab="", main="", do.axis=TRUE, cex.axis = 0.6)
#2/ weighted by the sqr root of inverse of std errors (so exclusion of SE in the variables)
data_clean2 <- read_excel("data_clean_5red_invse.xlsx")
aard1 = bms(data_clean2, burn=1e5,iter=3e5, g="UIP", mprior="dilut", nmodel=10000, mcmc="bd", user.int=FALSE) #central in graph & table Bajzik et al. (2020)
coef(aard1, order.by.pip = T, exact=T, include.constant=T)
image(aard1, yprop2pip=FALSE, order.by.pip=TRUE, do.par=TRUE, do.grid=TRUE, xlab="", main="", do.axis=TRUE, cex.axis = 0.6)

******************************************************************************
******************************************************************************
* HETEROGENEITY - FREQUENTIST MODEL AVERAGING (MALLOWS) ////CODE for R////
******************************************************************************
******************************************************************************
#Loading libraries
library(foreign)
library(xtable)
library(LowRankQP)

datadaylight <- read_excel("data_clean_5red.xlsx")
#deleting missing observations
datadaylight <-na.omit(datadaylight)
x.data <- datadaylight[,-1]
#adding constant
const_<-c(1)
x.data <-cbind(const_,x.data)

#******************************************************************************
x <- sapply(1:ncol(x.data),function(i){x.data[,i]/max(x.data[,i])})   
scale.vector <- as.matrix(sapply(1:ncol(x.data),function(i){max(x.data[,i])}))        
Y <- as.matrix(datadaylight[,1])
output.colnames <- colnames(x.data)
full.fit <- lm(Y~x-1)
beta.full <- as.matrix(coef(full.fit))
M <- k <- ncol(x)
n <- nrow(x)
beta <- matrix(0,k,M)
e <- matrix(0,n,M)
K_vector <- matrix(c(1:M))
var.matrix <- matrix(0,k,M)
bias.sq <- matrix(0,k,M) 
******************************************************************************            
#MMA estimator using orthogonalization 
for(i in 1:M)
{
  X <- as.matrix(x[,1:i])
  ortho <- eigen(t(X)%*%X)
  Q <- ortho$vectors ; lambda <- ortho$values 
  x.tilda <- X%*%Q%*%(diag(lambda^-0.5,i,i))
  beta.star <- t(x.tilda)%*%Y
  beta.hat <- Q%*%diag(lambda^-0.5,i,i)%*%beta.star
  beta[1:i,i] <- beta.hat
  e[,i] <- Y-x.tilda%*%as.matrix(beta.star)
  bias.sq[,i] <- (beta[,i]-beta.full)^2
  var.matrix.star <- diag(as.numeric(((t(e[,i])%*%e[,i])/(n-i))),i,i)
  var.matrix.hat <- var.matrix.star%*%(Q%*%diag(lambda^-1,i,i)%*%t(Q))
  var.matrix[1:i,i] <- diag(var.matrix.hat)
  var.matrix[,i] <- var.matrix[,i]+ bias.sq[,i]
} 
#End loop over i

#******************************************************************************
e_k <- e[,M]
sigma_hat <- as.numeric((t(e_k)%*%e_k)/(n-M))
G <- t(e)%*%e
a <- ((sigma_hat)^2)*K_vector
A <- matrix(1,1,M)
b <- matrix(1,1,1)
u <- matrix(1,M,1)
optim <- LowRankQP(Vmat=G,dvec=a,Amat=A,bvec=b,uvec=u,method="LU",verbose=FALSE)
weights <- as.matrix(optim$alpha)
beta.scaled <- beta%*%weights
final.beta <- beta.scaled/scale.vector
std.scaled <- sqrt(var.matrix)%*%weights
final.std <- std.scaled/scale.vector
results.reduced <- as.matrix(cbind(final.beta,final.std))
rownames(results.reduced) <- output.colnames; colnames(results.reduced) <- c("Coefficient", "Sd. Err")
MMA.fls <- round(results.reduced,4)
MMA.fls <- data.frame(MMA.fls)
t <- as.data.frame(MMA.fls$Coefficient/MMA.fls$Sd..Err)
MMA.fls$pv <-round( (1-apply(as.data.frame(apply(t,1,abs)), 1, pnorm))*2,3)
MMA.fls$names <- rownames(MMA.fls)
names <- c(colnames(datadaylight))
names <- c(names,"const_")
MMA.fls <- MMA.fls[match(names, MMA.fls$names),]
MMA.fls$names <- NULL
MMA.fls

******************************************************************************
******************************************************************************
* PUBLICATION BIAS - TOP10 method (Stanley et al., 2010)
******************************************************************************
******************************************************************************
summarize invse_day_w1, detail
gen top10bound = r(p90)
summarize coef_impact_day_w1 invse_day_w1 if invse_day_w1 > top10bound
summarize coef_impact_day_w1 invse_day_w1 if invse_day_w1 > top10bound & only_usa==1
summarize coef_impact_day_w1 invse_day_w1 if invse_day_w1 > top10bound & only_usa==0
******************************************************************************
******************************************************************************
