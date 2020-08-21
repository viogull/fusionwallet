import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/widgets.dart';

class TermsConditions extends StatefulWidget {
  static const String navId = '/TermsConditions';
  @override
  _TermsConditionsState createState() => new _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String privacyPolicy = """
This Privacy Policy describes the ways we collect, store, use and manage any Personal Data you provide to us or we collect in connection with your use of DropsTab website accessible at https://fusion.news and our other websites on which this Policy appears (the ‘Site’). 
When we say ‘Personal Data’ we mean identifiable information about you, like your email address, username, portfolio information, comments and so on. If you can’t be identified (for example, when Personal Data has been aggregated and anonymized), then this Policy does not apply. 
BY REGISTERING ON THE SITE AND/OR BY USING THE SITE YOU AGREE TO THIS PRIVACY POLICY and the processing of your Personal Data in the manner provided in this Policy. If you do not agree to the terms of this Privacy Policy, please do not use the Site.
    """;
    final String informationWeCollect = """
When you visit our Site we collect and process your Personal Data. The ways we collect it can be categorized into the following: 
 • Information you provide to us directly. When you visit or use some parts of our Site we might ask you to provide Personal Data to us. For example, (i) we need your email address and username to set up your account, (ii) when you use your portfolio account you provide us with information relating to your portfolio, or (iii) we ask for your email address if you would like to receive our newsletters.
 
 • Information we collect automatically. We collect some information about you automatically when you visit and use our Site, like your IP address, the type of device you use, browser type, version and language, type and version of your operating system, your activity on the Site, the number and frequency of visitors to the Site. This information is useful for us as it helps us get a better understanding of how you are using our Site so that we can continue to provide the best experience possible. Some of this information is collected using cookies or similar tracking technologies.

    """;
    final String cookieAndOther = """
A cookie is a small piece of text sent to your browser by a website you visit. It helps our Site to remember information about your visit. That can make your next visit easier and our Site more useful to you.
We use both session cookies and persistent cookies. A persistent cookie remains after you close your browser. Persistent cookies may be used by your browser on subsequent visits to our Site. Persistent cookies can be removed by following your web browser help file directions. Session cookies are temporary and typically disappear after you close your browser.
We use our own cookies (first party cookies):

 • To remember your choice about cookies on the Site.

 • To recognize you when you visit the Site.

 • To remember your preferences.

 • To perform security measures.

In addition, we work with reputable companies who can use their cookies when you use the Site (third party cookies). Third-party cookies are used, for example to count how many visitors we receive, to help us analyze how the Site is used (Google Analytics and other analytics services’ cookies). The cookies collect information in an anonymous form, including the number of visitors to the Site, where visitors have come to the Site from and the pages they visited. We use this information to compile reports and to help us improve the Site.
As mentioned, we use Google Analytics, in particular, to collect Site-specific usage data. Google Analytics collects only anonymous information rather than your email or other identifying information. We do not combine the information collected through the use of Google Analytics with your Personal Data. Although Google Analytics plants a permanent cookie on the web browser you use to identify you as a unique user, the cookie cannot be used by anyone but Google. Google’s ability to use and share information collected by Google Analytics is restricted by the Google Analytics Terms of Service and the Google Privacy Policy.
Most web browsers allow some control of most cookies through the browser settings. To find out more about cookies, including how to see what cookies have been set and how to manage and delete them, visit www.aboutcookies.org or www.allaboutcookies.org.
You may be able to reset your web browser to refuse all cookies or to indicate when a cookie is being sent. However, some features of the Site may not function properly if the ability to accept cookies is disabled.
We have done our best to provide you with clear and comprehensive information about our use of cookies. If you choose to use the Site without blocking or disabling cookies, you will indicate your consent to our use of these cookies and to our use (in accordance with this Privacy Policy) of any information that we collect using these technologies. If you do not consent to the use of cookies, please be sure to block or disable them using your browser settings, the opt-out links above, or the settings on your device.
    """;
    final String legalBases = """
Where we collect Personal Data, we will only process it when we have the legal basis for the processing set out in applicable data protection laws. Such legal bases are:

 • The performance of a contract. We may process your Personal Data where it is necessary for the performance of a contract entered into between you and us, or when we need to take steps related to such a contract. For example, when you use the Site you enter into an agreement with us.

 • A legal obligation. Various laws and regulations impose certain obligations on us. To comply with them we have to process your Personal Data.

 • The legitimate interests. Your Personal Data may be processed when we or other third parties have a business or commercial reason to process your Personal Data.

 • In certain limited cases we may process your Personal Data based on your consent.
    """;
    final String whyWeProcessPersonalData = """
The Information is used for:
 • Delivering you the Site and its functionality,

 • Your seamless interaction with the Site,

 • Analytical and statistical purposes,

 • Understanding your interaction with the Site,

 • Improvement and development of the Site or our other services and products,

 • Compliance with the applicable law, regulation, legal process or governmental request,

 • Detection, prevention, or otherwise addressing fraud, security or technical issues, abusive or unlawful use of the Site,

 • Disclosure of information to companies in our group of companies following a restructure or for internal administrative purposes,

 • Enforcement of this Policy and the Terms of Use, and

 • Sending you related information, including newsletters, special offers, confirmations, updates and security alerts.

Our processing of your Personal Data may be necessary for us to provide you with the services you have requested. If we do not process your Personal Data, we may be unable to provide you with all our services, and some functions and features on our Site may not be available to you.
    """;
    final String howLong = """
When you visit our Site we collect and process your Personal Data. The ways we collect it can be categorized into the following: 
 • Information you provide to us directly. When you visit or use some parts of our Site we might ask you to provide Personal Data to us. For example, (i) we need your email address and username to set up your account, (ii) when you use your portfolio account you provide us with information relating to your portfolio, or (iii) we ask for your email address if you would like to receive our newsletters.
 
 • Information we collect automatically. We collect some information about you automatically when you visit and use our Site, like your IP address, the type of device you use, browser type, version and language, type and version of your operating system, your activity on the Site, the number and frequency of visitors to the Site. This information is useful for us as it helps us get a better understanding of how you are using our Site so that we can continue to provide the best experience possible. Some of this information is collected using cookies or similar tracking technologies.

    """;
    final String disclosureoOfInformation = """
There will be times when we need to share your Personal Data with third parties. We will disclose your Personal Data to:

 • Other companies in our group of companies,

 • Third-party service providers, contractors and partners who assist us in the provision of the Site or who help with our business operations,

 • Law enforcement agencies, government bodies, courts or other third parties, where we think it is necessary to comply with applicable laws or regulations, or to exercise, establish or defend our legal rights (where possible and appropriate, we will notify you of this type of disclosure),

 • An actual or potential buyer (and its agents and advisers) in connection with an actual or proposed purchase, merger or acquisition of any part of our business, and/or

 • Other persons where we have your consent.
    """;
    final String yourRights = """
When the EU General Data Protection Regulation (GDPR) applies to our relations (e.g. you are located in the EU), you have the following rights with respect to your Personal Data that we process:

 • Right to access. You have the right to access (and obtain a copy of, if required) your Personal Data.

 • Right to rectification. You have the right to update your Personal Data or to correct any inaccuracies.

 • Right to erasure. You may have the right to request that we delete your Personal Data in certain circumstances, such as when it is no longer necessary for the purpose for which it was originally collected.

 • Right to restriction of processing. You may have the right to request to restrict the use of your Personal Data in certain circumstances, such as when you have objected to our use of your Personal Data but we need to verify whether we have overriding legitimate grounds to use it.

 • Right to data portability. You have the right to transfer your Personal Data to a third party in a structured, commonly used and machine-readable format, in circumstances where the Personal Data is processed with your consent or by automated means.

 • Right to object. You may have the right to object to the use of your Personal Data in certain circumstances, such as the use of your Personal Data for direct marketing.
 
 • Right to complain. You have the right to complain to your local data protection authority. This right may not be available to you if there is no authority dealing with data protection in your country.

You can exercise your rights at any time by making adjustments in your account or by sending an email to Fusion24pro@gmail.com.
    """;
    final String securityOfPersonalData = """
We are committed to protecting your Personal Data and have appropriate technical and organizational measures in place to protect data from loss, misuse and unauthorized access, disclosure, alteration and destruction. We process all Personal Data using industry-standard techniques. We restrict access to such information to our employees, contractors, and agents who need that information in order to process it. Our security team continuously monitors security systems, event logs, notifications and alerts from all systems to identify and manage threats.
    """;
    final String internationalDataTransfers = """
When we process and share data, it may be transferred to, and processed in, countries other than your country. These countries may have laws different to what you are used to. Where Personal Data are processed in another country, we put safeguards in place to ensure your Personal Data remains protected. 
For individuals in the European Economic Area (EEA), this means that your data may be transferred outside of the EEA. Where your Personal Data is transferred outside the EEA, it will be transferred to countries where we have compliant transfer mechanisms in place to protect your Personal Data, in particular, by implementing the European Commission’s Standard Contractual Clauses to the contracts with the entities the data is transferred to.
    """;
    final String modifications = """
We may modify or revise this Policy at any time by posting the amended Policy on the Site. Please check the most current Policy.
    """;
    final String privacyRelatedInquiries = """
If, for any reason, you are concerned with the way that we may be using your Personal Data, you have questions about the privacy aspects of the Site, please, contact us at Fusion24pro@gmail.com.
Last updated: June 07, 2020
    """;

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarTermsConditionsTitle(),
      child: Container(
        padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: ListView(
          children: [
            Center(
                child: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            Text(privacyPolicy,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "1. Information We Collect",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(informationWeCollect,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "2. Cookies and Other Tracking Technologies",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(cookieAndOther,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "3. Legal Bases to Process Personal Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(legalBases,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "4. Why We Process Personal Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(whyWeProcessPersonalData,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "5. How Long We Retain Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "6. How Long We Retain Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "7. How Long We Retain Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "8. How Long We Retain Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "9. International Data Transfers",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "10. Modifications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
            Text(
              "11. Privacy Related Inquiries",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(howLong,
                style: TextStyle(
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
