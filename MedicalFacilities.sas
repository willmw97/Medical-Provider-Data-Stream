/************************************
* Name: SAS Code to read in         *
*       Medicare/Medicaid data set. *
*       We will edit the file that  *
*       came with the data.         *
*                                   *
* Date: February 12, 2019           *
*                                   *
* Author: Marshal Will              *
************************************/

DATA Medicare;
	LENGTH
		npi              					$ 10
		nppes_provider_last_org_name 		$ 70
		nppes_provider_first_name 			$ 20
		nppes_provider_mi					$ 1
		nppes_credentials 					$ 20
		nppes_provider_gender				$ 1
		nppes_entity_code 					$ 1
		nppes_provider_street1 				$ 55
		nppes_provider_street2				$ 55
		nppes_provider_city 				$ 40
		nppes_provider_zip 					$ 20
		nppes_provider_state				$ 2
		nppes_provider_country				$ 2
		provider_type 						$ 43
		medicare_participation_indicator 	$ 1
		place_of_service					$ 1
		hcpcs_code       					$ 5
		hcpcs_description 					$ 256
		hcpcs_drug_indicator				$ 1
		line_srvc_cnt      					8
		bene_unique_cnt    					8
		bene_day_srvc_cnt   				8
		average_Medicare_allowed_amt   		8
		average_submitted_chrg_amt  		8
		average_Medicare_payment_amt   		8
		average_Medicare_standard_amt		8;
	/**** Their INFILE Statement
	INFILE 'C:\My Documents\Medicare_Provider_Util_Payment_PUF_CY2015.TXT' 

	Note: Obs and end options to INFILE have been added for Handout #7
	*/
	
	INFILE '/folders/myfolders/Med/Medicare_Provider_Util_Payment_PUF_CY2015.TXT'

		lrecl=32767
		dlm='09'x
		pad missover
		firstobs = 3
		dsd
  		/* OBS = 10000000000 */
  		end = EOF;
  		;


	INPUT
		npi             
		nppes_provider_last_org_name 
		nppes_provider_first_name 
		nppes_provider_mi 
		nppes_credentials 
		nppes_provider_gender 
		nppes_entity_code 
		nppes_provider_street1 
		nppes_provider_street2 
		nppes_provider_city 
		nppes_provider_zip 
		nppes_provider_state 
		nppes_provider_country 
		provider_type 
		medicare_participation_indicator 
		place_of_service 
		hcpcs_code       
		hcpcs_description 
		hcpcs_drug_indicator
		line_srvc_cnt    
		bene_unique_cnt  
		bene_day_srvc_cnt 
		average_Medicare_allowed_amt 
		average_submitted_chrg_amt 
		average_Medicare_payment_amt
		average_Medicare_standard_amt;

	LABEL
		npi     							= "National Provider Identifier"       
		nppes_provider_last_org_name 		= "Last Name/Organization Name of the Provider"
		nppes_provider_first_name 			= "First Name of the Provider"
		nppes_provider_mi					= "Middle Initial of the Provider"
		nppes_credentials 					= "Credentials of the Provider"
		nppes_provider_gender 				= "Gender of the Provider"
		nppes_entity_code 					= "Entity Type of the Provider"
		nppes_provider_street1 				= "Street Address 1 of the Provider"
		nppes_provider_street2 				= "Street Address 2 of the Provider"
		nppes_provider_city 				= "City of the Provider"
		nppes_provider_zip 					= "Zip Code of the Provider"
		nppes_provider_state 				= "State Code of the Provider"
		nppes_provider_country 				= "Country Code of the Provider"
		provider_type	 					= "Provider Type of the Provider"
		medicare_participation_indicator 	= "Medicare Participation Indicator"
		place_of_service 					= "Place of Service"
		hcpcs_code       					= "HCPCS Code"
		hcpcs_description 					= "HCPCS Description"
		hcpcs_drug_indicator				= "Identifies HCPCS As Drug Included in the ASP Drug List"
		line_srvc_cnt    					= "Number of Services"
		bene_unique_cnt  					= "Number of Medicare Beneficiaries"
		bene_day_srvc_cnt 					= "Number of Distinct Medicare Beneficiary/Per Day Services"
		average_Medicare_allowed_amt 		= "Average Medicare Allowed Amount"
		average_submitted_chrg_amt 			= "Average Submitted Charge Amount"
		average_Medicare_payment_amt 		= "Average Medicare Payment Amount"
		average_Medicare_standard_amt		= "Average Medicare Standardized Payment Amount";
	
	ObsNumber = _N_;
	retain countF countO;


	If place_of_service = 'F' then countF = sum(countF,line_srvc_cnt);
	If place_of_service = 'O' then countO = sum(countO,line_srvc_cnt);
	IF MOD(ObsNumber,1000000) = 0 OR EOF THEN OUTPUT;


RUN;

**** Checking CONTENTS of Medicare Dataset;
PROC CONTENTS DATA=Medicare;
RUN;

**** Printing the Medicare Dataset;
PROC PRINT DATA=Medicare;
  VAR ObsNumber line_srvc_cnt average_Medicare_payment_amt countF countO;
RUN;



QUIT;