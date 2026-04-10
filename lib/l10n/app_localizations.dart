import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @sim1_intro_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Safe Online'**
  String get sim1_intro_appBarTitle;

  /// No description provided for @sim1_intro_heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Safe from\nGovernment Scheme Scams'**
  String get sim1_intro_heroTitle;

  /// No description provided for @sim1_intro_heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Many fraud calls and messages target farmers.\nThis lesson will help you protect yourself.'**
  String get sim1_intro_heroSubtitle;

  /// No description provided for @sim1_intro_youWillLearn.
  ///
  /// In en, this message translates to:
  /// **'You will learn:'**
  String get sim1_intro_youWillLearn;

  /// No description provided for @sim1_intro_fakeLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Fake links'**
  String get sim1_intro_fakeLinksTitle;

  /// No description provided for @sim1_intro_fakeLinksDesc.
  ///
  /// In en, this message translates to:
  /// **'Bit.ly or unknown links are dangerous. Real sites end in .gov.in'**
  String get sim1_intro_fakeLinksDesc;

  /// No description provided for @sim1_intro_fakeOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Fake OTP requests'**
  String get sim1_intro_fakeOtpTitle;

  /// No description provided for @sim1_intro_fakeOtpDesc.
  ///
  /// In en, this message translates to:
  /// **'No government officer ever asks for OTP. That\'s a scam.'**
  String get sim1_intro_fakeOtpDesc;

  /// No description provided for @sim1_intro_safeInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Safe information'**
  String get sim1_intro_safeInfoTitle;

  /// No description provided for @sim1_intro_safeInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Only share basic details — never passwords, PINs, or full bank info.'**
  String get sim1_intro_safeInfoDesc;

  /// No description provided for @sim1_intro_urgencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Urgency tricks'**
  String get sim1_intro_urgencyTitle;

  /// No description provided for @sim1_intro_urgencyDesc.
  ///
  /// In en, this message translates to:
  /// **'Scammers say \'Act now or lose money!\' — this is a trick to panic you.'**
  String get sim1_intro_urgencyDesc;

  /// No description provided for @sim1_intro_warningText.
  ///
  /// In en, this message translates to:
  /// **'Never trust unknown links or urgent messages asking for money or OTP. When in doubt — CALL YOUR FAMILY FIRST.'**
  String get sim1_intro_warningText;

  /// No description provided for @sim1_intro_startBtn.
  ///
  /// In en, this message translates to:
  /// **'Start Learning'**
  String get sim1_intro_startBtn;

  /// No description provided for @sim1_form_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Scheme Application Form'**
  String get sim1_form_appBarTitle;

  /// No description provided for @sim1_form_scamAlert.
  ///
  /// In en, this message translates to:
  /// **'SCAM ALERT: No government officer will call you after this form asking for OTP or money. If someone calls, IT IS A SCAM.'**
  String get sim1_form_scamAlert;

  /// No description provided for @sim1_form_fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ramesh Kumar Sharma'**
  String get sim1_form_fullNameHint;

  /// No description provided for @sim1_form_fatherNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Suresh Kumar Sharma'**
  String get sim1_form_fatherNameHint;

  /// No description provided for @sim1_form_mobileHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit mobile number'**
  String get sim1_form_mobileHint;

  /// No description provided for @sim1_form_aadhaarLesson.
  ///
  /// In en, this message translates to:
  /// **'LESSON: Enter Aadhaar ONLY on official .gov.in websites. This form is a simulation.'**
  String get sim1_form_aadhaarLesson;

  /// No description provided for @sim1_form_aadhaarHint.
  ///
  /// In en, this message translates to:
  /// **'12-digit Aadhaar number'**
  String get sim1_form_aadhaarHint;

  /// No description provided for @sim1_form_aadhaarWarning.
  ///
  /// In en, this message translates to:
  /// **'Real Aadhaar should only be entered on official government websites ending in .gov.in\n\nExample: https://pmkisan.gov.in\n\nNEVER share Aadhaar on unknown sites or WhatsApp.'**
  String get sim1_form_aadhaarWarning;

  /// No description provided for @sim1_form_bankLesson.
  ///
  /// In en, this message translates to:
  /// **'LESSON: Bank details are needed for direct benefit transfer (DBT). Never share your bank PASSWORD or OTP — only account number is needed here.'**
  String get sim1_form_bankLesson;

  /// No description provided for @sim1_form_bankHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 12345678901234'**
  String get sim1_form_bankHint;

  /// No description provided for @sim1_form_bankWarning.
  ///
  /// In en, this message translates to:
  /// **'Bank account number is used to send money directly to you (DBT).\n\nSafe to enter here.\nBUT: Never share your ATM PIN, internet banking password, or OTP.'**
  String get sim1_form_bankWarning;

  /// No description provided for @sim1_form_ifscHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. SBIN0001234'**
  String get sim1_form_ifscHint;

  /// No description provided for @sim1_form_villageHint.
  ///
  /// In en, this message translates to:
  /// **'Your village or town name'**
  String get sim1_form_villageHint;

  /// No description provided for @sim1_form_declarationText.
  ///
  /// In en, this message translates to:
  /// **'I hereby declare that the information provided in this form is true and correct to the best of my knowledge. I understand that providing false information may lead to cancellation of benefits and legal action under relevant laws.'**
  String get sim1_form_declarationText;

  /// No description provided for @sim1_form_declarationCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I have read and accept the above declaration.'**
  String get sim1_form_declarationCheckbox;

  /// No description provided for @sim1_form_submitBtn.
  ///
  /// In en, this message translates to:
  /// **'Submit Application'**
  String get sim1_form_submitBtn;

  /// No description provided for @sim1_form_submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get sim1_form_submitting;

  /// No description provided for @sim1_form_footer.
  ///
  /// In en, this message translates to:
  /// **'For help, call Kisan Helpline: 1800-180-1551 (Free)\nThis is a simulation. Not a real government website.'**
  String get sim1_form_footer;

  /// No description provided for @sim1_form_declarationRequired.
  ///
  /// In en, this message translates to:
  /// **'Declaration Required'**
  String get sim1_form_declarationRequired;

  /// No description provided for @sim1_form_declarationRequiredMsg.
  ///
  /// In en, this message translates to:
  /// **'Please read and accept the declaration at the bottom before submitting.'**
  String get sim1_form_declarationRequiredMsg;

  /// No description provided for @sim1_form_confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Submission'**
  String get sim1_form_confirmTitle;

  /// No description provided for @sim1_form_confirmWarning.
  ///
  /// In en, this message translates to:
  /// **'⚠ IMPORTANT: Real government websites NEVER ask for:\n• OTP over phone\n• Payment to process application\n• Password of any account\n\nThis is a SIMULATION to help you learn.'**
  String get sim1_form_confirmWarning;

  /// No description provided for @sim1_call_callerName.
  ///
  /// In en, this message translates to:
  /// **'Gov Scheme Officer'**
  String get sim1_call_callerName;

  /// No description provided for @sim1_call_callerNumber.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get sim1_call_callerNumber;

  /// No description provided for @sim1_call_unknownWarning.
  ///
  /// In en, this message translates to:
  /// **'Unknown number — be careful!'**
  String get sim1_call_unknownWarning;

  /// No description provided for @sim1_call_slideHint.
  ///
  /// In en, this message translates to:
  /// **'Slide to answer or decline'**
  String get sim1_call_slideHint;

  /// No description provided for @sim1_call_decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get sim1_call_decline;

  /// No description provided for @sim1_call_accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get sim1_call_accept;

  /// No description provided for @sim1_call_scammerSaying.
  ///
  /// In en, this message translates to:
  /// **'Scammer is saying...'**
  String get sim1_call_scammerSaying;

  /// No description provided for @sim1_call_govNeverOtp.
  ///
  /// In en, this message translates to:
  /// **'Government NEVER asks for OTP on a call. This is a scam.'**
  String get sim1_call_govNeverOtp;

  /// No description provided for @sim1_call_whatWillYouDo.
  ///
  /// In en, this message translates to:
  /// **'What will you do?'**
  String get sim1_call_whatWillYouDo;

  /// No description provided for @sim1_call_shareOtp.
  ///
  /// In en, this message translates to:
  /// **'Share OTP'**
  String get sim1_call_shareOtp;

  /// No description provided for @sim1_call_hangUp.
  ///
  /// In en, this message translates to:
  /// **'Hang Up — Never Share OTP'**
  String get sim1_call_hangUp;

  /// No description provided for @sim1_otp_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get sim1_otp_appBarTitle;

  /// No description provided for @sim1_otp_submitBtn.
  ///
  /// In en, this message translates to:
  /// **'Submit OTP'**
  String get sim1_otp_submitBtn;

  /// No description provided for @sim1_link_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the Safe Website'**
  String get sim1_link_appBarTitle;

  /// No description provided for @sim1_link_question.
  ///
  /// In en, this message translates to:
  /// **'Which website is SAFE to visit?'**
  String get sim1_link_question;

  /// No description provided for @sim1_link_tapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the one you think is the real government website.'**
  String get sim1_link_tapHint;

  /// No description provided for @sim1_link_fakeTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Subsidy Portal'**
  String get sim1_link_fakeTitle;

  /// No description provided for @sim1_link_fakeUrl.
  ///
  /// In en, this message translates to:
  /// **'http://bit.ly/kisan-help'**
  String get sim1_link_fakeUrl;

  /// No description provided for @sim1_link_tipHeader.
  ///
  /// In en, this message translates to:
  /// **'How to check a safe website:'**
  String get sim1_link_tipHeader;

  /// No description provided for @sim1_link_tip1.
  ///
  /// In en, this message translates to:
  /// **'Starts with https://'**
  String get sim1_link_tip1;

  /// No description provided for @sim1_link_tip2.
  ///
  /// In en, this message translates to:
  /// **'Ends with .gov.in for Indian government'**
  String get sim1_link_tip2;

  /// No description provided for @sim1_link_tip3.
  ///
  /// In en, this message translates to:
  /// **'Avoid bit.ly, tinyurl, or unknown names'**
  String get sim1_link_tip3;

  /// No description provided for @sim1_link_tip4.
  ///
  /// In en, this message translates to:
  /// **'Avoid sites with spelling mistakes (e.g. \'g0v.in\')'**
  String get sim1_link_tip4;

  /// No description provided for @sim1_link_correctTitle.
  ///
  /// In en, this message translates to:
  /// **'Correct! ✅'**
  String get sim1_link_correctTitle;

  /// No description provided for @sim1_link_wrongTitle.
  ///
  /// In en, this message translates to:
  /// **'Wrong! ❌'**
  String get sim1_link_wrongTitle;

  /// No description provided for @sim1_success_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Simulation Result'**
  String get sim1_success_appBarTitle;

  /// No description provided for @sim1_success_stayedSafe.
  ///
  /// In en, this message translates to:
  /// **'You Stayed Safe! 🎉'**
  String get sim1_success_stayedSafe;

  /// No description provided for @sim1_success_almostScammed.
  ///
  /// In en, this message translates to:
  /// **'You Almost Got Scammed! ❌'**
  String get sim1_success_almostScammed;

  /// No description provided for @sim1_success_safeMsg.
  ///
  /// In en, this message translates to:
  /// **'Excellent! You made the right choice.\n\nYou checked the website carefully and avoided sharing sensitive information. This is exactly how you protect yourself from scammers.'**
  String get sim1_success_safeMsg;

  /// No description provided for @sim1_success_scammedMsg.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry — this is a simulation to help you learn.\n\nScammers use urgency, fake links, and fake calls to steal your money. Now you know their tricks. Next time you will catch it!'**
  String get sim1_success_scammedMsg;

  /// No description provided for @sim1_success_keyLearnings.
  ///
  /// In en, this message translates to:
  /// **'Key Learnings:'**
  String get sim1_success_keyLearnings;

  /// No description provided for @sim1_success_learn1.
  ///
  /// In en, this message translates to:
  /// **'Never share OTP with anyone on phone'**
  String get sim1_success_learn1;

  /// No description provided for @sim1_success_learn2.
  ///
  /// In en, this message translates to:
  /// **'Only visit websites ending in .gov.in'**
  String get sim1_success_learn2;

  /// No description provided for @sim1_success_learn3.
  ///
  /// In en, this message translates to:
  /// **'Ignore \'URGENT\' messages — that is a panic trick'**
  String get sim1_success_learn3;

  /// No description provided for @sim1_success_learn4.
  ///
  /// In en, this message translates to:
  /// **'If in doubt, call your family or 1930 helpline'**
  String get sim1_success_learn4;

  /// No description provided for @sim1_success_learn5.
  ///
  /// In en, this message translates to:
  /// **'Government NEVER asks for money to give benefits'**
  String get sim1_success_learn5;

  /// No description provided for @sim1_success_badgeSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe Choice'**
  String get sim1_success_badgeSafe;

  /// No description provided for @sim1_success_badgeRisky.
  ///
  /// In en, this message translates to:
  /// **'Risky Choice'**
  String get sim1_success_badgeRisky;

  /// No description provided for @sim1_success_badgeLearn.
  ///
  /// In en, this message translates to:
  /// **'Keep Learning'**
  String get sim1_success_badgeLearn;

  /// No description provided for @sim1_success_quizBtn.
  ///
  /// In en, this message translates to:
  /// **'Take the Quiz'**
  String get sim1_success_quizBtn;

  /// No description provided for @sim1_success_homeBtn.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get sim1_success_homeBtn;

  /// No description provided for @sim1_common_iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get sim1_common_iUnderstand;

  /// No description provided for @sim1_quiz_correct.
  ///
  /// In en, this message translates to:
  /// **'Correct! Well done.'**
  String get sim1_quiz_correct;

  /// No description provided for @sim1_result_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Result'**
  String get sim1_result_appBarTitle;

  /// No description provided for @sim1_result_rule1.
  ///
  /// In en, this message translates to:
  /// **'1. 🔒  NEVER share OTP with anyone'**
  String get sim1_result_rule1;

  /// No description provided for @sim1_result_rule2.
  ///
  /// In en, this message translates to:
  /// **'2. 🌐  Only use .gov.in websites'**
  String get sim1_result_rule2;

  /// No description provided for @sim1_result_rule3.
  ///
  /// In en, this message translates to:
  /// **'3. 📞  Call 1930 if something feels wrong'**
  String get sim1_result_rule3;

  /// No description provided for @sim1_result_rules.
  ///
  /// In en, this message translates to:
  /// **'Remember these 3 rules:'**
  String get sim1_result_rules;

  /// No description provided for @sim1_result_homeBtn.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get sim1_result_homeBtn;

  /// No description provided for @sim1_result_retryBtn.
  ///
  /// In en, this message translates to:
  /// **'Retry Quiz'**
  String get sim1_result_retryBtn;

  /// No description provided for @sim1_result_msg_perfect.
  ///
  /// In en, this message translates to:
  /// **'Outstanding! You are a Scam Expert!'**
  String get sim1_result_msg_perfect;

  /// No description provided for @sim1_result_msg_great.
  ///
  /// In en, this message translates to:
  /// **'Excellent! You are very aware of scams.'**
  String get sim1_result_msg_great;

  /// No description provided for @sim1_result_msg_good.
  ///
  /// In en, this message translates to:
  /// **'Good! A little more practice and you will be a pro.'**
  String get sim1_result_msg_good;

  /// No description provided for @sim1_result_msg_keepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going! Scammers are tricky — practice more.'**
  String get sim1_result_msg_keepGoing;

  /// No description provided for @sim1_result_msg_tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Do not worry — now you know the tricks. Try again!'**
  String get sim1_result_msg_tryAgain;

  /// No description provided for @sim1_result_badge_gold.
  ///
  /// In en, this message translates to:
  /// **'Gold Shield'**
  String get sim1_result_badge_gold;

  /// No description provided for @sim1_result_badge_aware.
  ///
  /// In en, this message translates to:
  /// **'Scam Aware'**
  String get sim1_result_badge_aware;

  /// No description provided for @sim1_result_badge_learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get sim1_result_badge_learning;

  /// No description provided for @sim1_result_badge_practice.
  ///
  /// In en, this message translates to:
  /// **'Needs Practice'**
  String get sim1_result_badge_practice;

  /// No description provided for @sim1_result_badge_retry.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get sim1_result_badge_retry;

  /// No description provided for @sim1_q1.
  ///
  /// In en, this message translates to:
  /// **'Someone calls and says \'Share your OTP to get your PM Kisan money\'. What should you do?'**
  String get sim1_q1;

  /// No description provided for @sim1_q1_opt1.
  ///
  /// In en, this message translates to:
  /// **'Share the OTP with them'**
  String get sim1_q1_opt1;

  /// No description provided for @sim1_q1_opt2.
  ///
  /// In en, this message translates to:
  /// **'Refuse and hang up — it is a scam'**
  String get sim1_q1_opt2;

  /// No description provided for @sim1_q1_opt3.
  ///
  /// In en, this message translates to:
  /// **'Share only if they say please'**
  String get sim1_q1_opt3;

  /// No description provided for @sim1_q2.
  ///
  /// In en, this message translates to:
  /// **'Which of these websites is SAFE for PM Kisan?'**
  String get sim1_q2;

  /// No description provided for @sim1_q2_opt1.
  ///
  /// In en, this message translates to:
  /// **'bit.ly/kisan-help'**
  String get sim1_q2_opt1;

  /// No description provided for @sim1_q2_opt2.
  ///
  /// In en, this message translates to:
  /// **'pmkisan-support.xyz'**
  String get sim1_q2_opt2;

  /// No description provided for @sim1_q2_opt3.
  ///
  /// In en, this message translates to:
  /// **'https://pmkisan.gov.in'**
  String get sim1_q2_opt3;

  /// No description provided for @sim1_q3.
  ///
  /// In en, this message translates to:
  /// **'You get a message: \'Pay ₹200 now or your scheme will be cancelled!\' What should you do?'**
  String get sim1_q3;

  /// No description provided for @sim1_q3_opt1.
  ///
  /// In en, this message translates to:
  /// **'Pay immediately'**
  String get sim1_q3_opt1;

  /// No description provided for @sim1_q3_opt2.
  ///
  /// In en, this message translates to:
  /// **'Ignore it and verify on the official website'**
  String get sim1_q3_opt2;

  /// No description provided for @sim1_q3_opt3.
  ///
  /// In en, this message translates to:
  /// **'Share your bank details'**
  String get sim1_q3_opt3;

  /// No description provided for @sim1_q4.
  ///
  /// In en, this message translates to:
  /// **'A WhatsApp message asks for your Aadhaar number for scheme benefit. Is this safe?'**
  String get sim1_q4;

  /// No description provided for @sim1_q4_opt1.
  ///
  /// In en, this message translates to:
  /// **'Yes, share it'**
  String get sim1_q4_opt1;

  /// No description provided for @sim1_q4_opt2.
  ///
  /// In en, this message translates to:
  /// **'No — never share Aadhaar on WhatsApp'**
  String get sim1_q4_opt2;

  /// No description provided for @sim1_q5.
  ///
  /// In en, this message translates to:
  /// **'Scammers send urgent messages because...?'**
  String get sim1_q5;

  /// No description provided for @sim1_q5_opt1.
  ///
  /// In en, this message translates to:
  /// **'They are very helpful people'**
  String get sim1_q5_opt1;

  /// No description provided for @sim1_q5_opt2.
  ///
  /// In en, this message translates to:
  /// **'Panic makes people act without thinking'**
  String get sim1_q5_opt2;

  /// No description provided for @sim1_q5_opt3.
  ///
  /// In en, this message translates to:
  /// **'They work for the government'**
  String get sim1_q5_opt3;

  /// No description provided for @sim1_quiz_appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz — Question {current} of {total}'**
  String sim1_quiz_appBarTitle(int current, int total);

  /// No description provided for @sim1_quiz_wrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong. The correct answer is: {answer}'**
  String sim1_quiz_wrong(String answer);

  /// No description provided for @sim1_result_score.
  ///
  /// In en, this message translates to:
  /// **'Your Score: {score} / {total}'**
  String sim1_result_score(int score, int total);

  /// No description provided for @sim1_result_scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'{score} out of {total} correct'**
  String sim1_result_scoreLabel(int score, int total);

  /// No description provided for @sim1_common_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get sim1_common_continue;

  /// No description provided for @sim1_common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get sim1_common_cancel;

  /// No description provided for @sim1_common_understood.
  ///
  /// In en, this message translates to:
  /// **'Understood'**
  String get sim1_common_understood;

  /// No description provided for @sim1_call_incomingCall.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call'**
  String get sim1_call_incomingCall;

  /// No description provided for @sim1_call_callConnected.
  ///
  /// In en, this message translates to:
  /// **'Call Connected'**
  String get sim1_call_callConnected;

  /// No description provided for @sim1_call_acceptOrDecline.
  ///
  /// In en, this message translates to:
  /// **'Slide to answer or decline'**
  String get sim1_call_acceptOrDecline;

  /// No description provided for @sim1_call_scammerScript.
  ///
  /// In en, this message translates to:
  /// **'\"Namaste ji! I am calling from PM Kisan office.\n\nYour ₹6000 payment is ready. Just share the OTP — right now — or the payment will be cancelled!\"'**
  String get sim1_call_scammerScript;

  /// No description provided for @sim1_call_resultSafeTitle.
  ///
  /// In en, this message translates to:
  /// **'Well Done! ✅'**
  String get sim1_call_resultSafeTitle;

  /// No description provided for @sim1_call_resultSafeBody.
  ///
  /// In en, this message translates to:
  /// **'You made the RIGHT choice!\n\nReal government officers NEVER ask for OTP on a phone call.\n\nPM Kisan payments happen automatically — no OTP needed. Anyone asking for OTP is a SCAMMER.'**
  String get sim1_call_resultSafeBody;

  /// No description provided for @sim1_call_resultSafeSpeak.
  ///
  /// In en, this message translates to:
  /// **'Well done! You made the right choice. Real government officers never ask for OTP on a phone call.'**
  String get sim1_call_resultSafeSpeak;

  /// No description provided for @sim1_call_resultWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops! ❌'**
  String get sim1_call_resultWrongTitle;

  /// No description provided for @sim1_call_resultWrongBody.
  ///
  /// In en, this message translates to:
  /// **'You fell for the scam!\n\nReal government officers NEVER ask for OTP.\n\nIf you share OTP, scammers can empty your bank account in minutes. Always hang up and call 1930 (Cyber Crime Helpline).'**
  String get sim1_call_resultWrongBody;

  /// No description provided for @sim1_call_resultWrongSpeak.
  ///
  /// In en, this message translates to:
  /// **'Oops! You fell for the scam. Real government officers never ask for OTP. Call 1930 if something feels wrong.'**
  String get sim1_call_resultWrongSpeak;

  /// No description provided for @sim1_form_headerTitle.
  ///
  /// In en, this message translates to:
  /// **'APPLICATION FOR GOVERNMENT SCHEME BENEFIT'**
  String get sim1_form_headerTitle;

  /// No description provided for @sim1_form_appBarSub.
  ///
  /// In en, this message translates to:
  /// **'Form No: GOI/AGRI/2024 | Simulation for learning only'**
  String get sim1_form_appBarSub;

  /// No description provided for @sim1_form_partAHeader.
  ///
  /// In en, this message translates to:
  /// **'Part A: Scheme Details'**
  String get sim1_form_partAHeader;

  /// No description provided for @sim1_form_partBHeader.
  ///
  /// In en, this message translates to:
  /// **'Part B: Personal Details'**
  String get sim1_form_partBHeader;

  /// No description provided for @sim1_form_partCHeader.
  ///
  /// In en, this message translates to:
  /// **'Part C: Identity Proof'**
  String get sim1_form_partCHeader;

  /// No description provided for @sim1_form_partDHeader.
  ///
  /// In en, this message translates to:
  /// **'Part D: Bank Account Details'**
  String get sim1_form_partDHeader;

  /// No description provided for @sim1_form_partEHeader.
  ///
  /// In en, this message translates to:
  /// **'Part E: Address Details'**
  String get sim1_form_partEHeader;

  /// No description provided for @sim1_form_selectSchemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Scheme *'**
  String get sim1_form_selectSchemeLabel;

  /// No description provided for @sim1_form_selectSchemeError.
  ///
  /// In en, this message translates to:
  /// **'Please select a scheme'**
  String get sim1_form_selectSchemeError;

  /// No description provided for @sim1_form_schemeList.
  ///
  /// In en, this message translates to:
  /// **'PM Kisan Samman Nidhi,PM Fasal Bima Yojana,Pradhan Mantri Awas Yojana,PM Ujjwala Yojana,Ayushman Bharat'**
  String get sim1_form_schemeList;

  /// No description provided for @sim1_form_fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name (As per Aadhaar) *'**
  String get sim1_form_fullNameLabel;

  /// No description provided for @sim1_form_fullNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get sim1_form_fullNameError;

  /// No description provided for @sim1_form_fatherNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Father\'s / Husband\'s Name *'**
  String get sim1_form_fatherNameLabel;

  /// No description provided for @sim1_form_fatherNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter father/husband name'**
  String get sim1_form_fatherNameError;

  /// No description provided for @sim1_form_mobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number (Linked to Aadhaar) *'**
  String get sim1_form_mobileLabel;

  /// No description provided for @sim1_form_mobileError.
  ///
  /// In en, this message translates to:
  /// **'Enter valid 10-digit mobile number'**
  String get sim1_form_mobileError;

  /// No description provided for @sim1_form_aadhaarLabel.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar Number *'**
  String get sim1_form_aadhaarLabel;

  /// No description provided for @sim1_form_aadhaarError.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar must be 12 digits'**
  String get sim1_form_aadhaarError;

  /// No description provided for @sim1_form_bankLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Number *'**
  String get sim1_form_bankLabel;

  /// No description provided for @sim1_form_bankError.
  ///
  /// In en, this message translates to:
  /// **'Enter valid account number'**
  String get sim1_form_bankError;

  /// No description provided for @sim1_form_ifscLabel.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code *'**
  String get sim1_form_ifscLabel;

  /// No description provided for @sim1_form_ifscErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter IFSC code'**
  String get sim1_form_ifscErrorEmpty;

  /// No description provided for @sim1_form_ifscErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid IFSC. Example: SBIN0001234'**
  String get sim1_form_ifscErrorInvalid;

  /// No description provided for @sim1_form_villageLabel.
  ///
  /// In en, this message translates to:
  /// **'Village / Town / City *'**
  String get sim1_form_villageLabel;

  /// No description provided for @sim1_form_villageError.
  ///
  /// In en, this message translates to:
  /// **'Enter your village or town'**
  String get sim1_form_villageError;

  /// No description provided for @sim1_form_stateLabel.
  ///
  /// In en, this message translates to:
  /// **'State *'**
  String get sim1_form_stateLabel;

  /// No description provided for @sim1_form_stateError.
  ///
  /// In en, this message translates to:
  /// **'Please select your state'**
  String get sim1_form_stateError;

  /// No description provided for @sim1_form_stateList.
  ///
  /// In en, this message translates to:
  /// **'Andhra Pradesh,Arunachal Pradesh,Assam,Bihar,Chhattisgarh,Goa,Gujarat,Haryana,Himachal Pradesh,Jharkhand,Karnataka,Kerala,Madhya Pradesh,Maharashtra,Manipur,Meghalaya,Mizoram,Nagaland,Odisha,Punjab,Rajasthan,Sikkim,Tamil Nadu,Telangana,Tripura,Uttar Pradesh,Uttarakhand,West Bengal'**
  String get sim1_form_stateList;

  /// No description provided for @sim1_form_declarationHeader.
  ///
  /// In en, this message translates to:
  /// **'Declaration'**
  String get sim1_form_declarationHeader;

  /// No description provided for @sim1_form_declarationHint.
  ///
  /// In en, this message translates to:
  /// **'Please read carefully before accepting'**
  String get sim1_form_declarationHint;

  /// No description provided for @sim1_form_cautionTitle.
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get sim1_form_cautionTitle;

  /// No description provided for @sim1_form_confirmBody.
  ///
  /// In en, this message translates to:
  /// **'You are about to submit your application.\n\n⚠ IMPORTANT: Real government websites NEVER ask for:\n• OTP over phone\n• Payment to process application\n• Password of any account\n\nThis is a SIMULATION to help you learn.'**
  String get sim1_form_confirmBody;

  /// No description provided for @sim1_form_confirmSpeak.
  ///
  /// In en, this message translates to:
  /// **'You are about to submit your application. Remember: real government websites never ask for OTP, payment, or passwords.'**
  String get sim1_form_confirmSpeak;

  /// No description provided for @sim1_form_validationError.
  ///
  /// In en, this message translates to:
  /// **'⚠ Please fill all required fields correctly.'**
  String get sim1_form_validationError;

  /// No description provided for @sim1_form_simulationNote.
  ///
  /// In en, this message translates to:
  /// **'This is a simulation. Not a real government website.'**
  String get sim1_form_simulationNote;

  /// No description provided for @sim1_otp_title.
  ///
  /// In en, this message translates to:
  /// **'Enter Your OTP'**
  String get sim1_otp_title;

  /// No description provided for @sim1_otp_subtitle.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to your registered mobile number'**
  String get sim1_otp_subtitle;

  /// No description provided for @sim1_otp_fieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit OTP'**
  String get sim1_otp_fieldLabel;

  /// No description provided for @sim1_otp_warningText.
  ///
  /// In en, this message translates to:
  /// **'Remember: NEVER share this OTP with anyone on phone — not even someone claiming to be from the government or bank.'**
  String get sim1_otp_warningText;

  /// No description provided for @sim1_otp_scamPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Incoming Message! 🚨'**
  String get sim1_otp_scamPopupTitle;

  /// No description provided for @sim1_otp_scamPopupBody.
  ///
  /// In en, this message translates to:
  /// **'\"Namaste ji, I am messaging from PM Kisan Office.\n\nYour ₹6000 payment is ready. Please share the OTP you just received to confirm your identity.\"'**
  String get sim1_otp_scamPopupBody;

  /// No description provided for @sim1_otp_scamPopupQuestion.
  ///
  /// In en, this message translates to:
  /// **'What will you do?'**
  String get sim1_otp_scamPopupQuestion;

  /// No description provided for @sim1_otp_scamPopupSpeak.
  ///
  /// In en, this message translates to:
  /// **'Warning! Scam message received. Someone is asking for your OTP. Never share OTP with anyone.'**
  String get sim1_otp_scamPopupSpeak;

  /// No description provided for @sim1_otp_shareOtpBtn.
  ///
  /// In en, this message translates to:
  /// **'Share OTP'**
  String get sim1_otp_shareOtpBtn;

  /// No description provided for @sim1_otp_refuseBtn.
  ///
  /// In en, this message translates to:
  /// **'Refuse & Block'**
  String get sim1_otp_refuseBtn;

  /// No description provided for @sim1_otp_safeChoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Great Choice! ✅'**
  String get sim1_otp_safeChoiceTitle;

  /// No description provided for @sim1_otp_safeChoiceBody.
  ///
  /// In en, this message translates to:
  /// **'You are RIGHT to refuse!\n\nNo government officer EVER asks for OTP on phone or message.\n\nReal PM Kisan payments happen automatically — no OTP needed.\n\nIf someone asks for OTP, it is ALWAYS a scam. Block and call 1930.'**
  String get sim1_otp_safeChoiceBody;

  /// No description provided for @sim1_otp_safeChoiceSpeak.
  ///
  /// In en, this message translates to:
  /// **'Great choice! You refused to share the OTP. No government officer ever asks for OTP.'**
  String get sim1_otp_safeChoiceSpeak;

  /// No description provided for @sim1_otp_submitDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Wait! ⚠'**
  String get sim1_otp_submitDialogTitle;

  /// No description provided for @sim1_otp_submitDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Did someone on the phone ask for this OTP?\n\nIf YES — that is a SCAM. Stop. Hang up.\n\nYou only enter OTP on the WEBSITE — never tell it to anyone.'**
  String get sim1_otp_submitDialogBody;

  /// No description provided for @sim1_otp_submitWarningSpeak.
  ///
  /// In en, this message translates to:
  /// **'Wait! Did someone ask you for this OTP on the phone? If yes, that is a scam. Hang up immediately.'**
  String get sim1_otp_submitWarningSpeak;

  /// No description provided for @sim1_link_safeTitle.
  ///
  /// In en, this message translates to:
  /// **'PM Kisan Official Website'**
  String get sim1_link_safeTitle;

  /// No description provided for @sim1_link_safeUrl.
  ///
  /// In en, this message translates to:
  /// **'https://pmkisan.gov.in'**
  String get sim1_link_safeUrl;

  /// No description provided for @sim1_link_fakeExplanation.
  ///
  /// In en, this message translates to:
  /// **'⚠ \'bit.ly\' hides the real link. \'http\' has no security. Avoid.'**
  String get sim1_link_fakeExplanation;

  /// No description provided for @sim1_link_safeExplanation.
  ///
  /// In en, this message translates to:
  /// **'✅ \'https\' = secure. \'.gov.in\' = real Indian government website.'**
  String get sim1_link_safeExplanation;

  /// No description provided for @sim1_link_correctBody.
  ///
  /// In en, this message translates to:
  /// **'You chose the REAL government website!\n\nRemember:\n• \'https://\' = secure\n• \'.gov.in\' = official Indian government\n• Long, clear address = safe\n\nAlways bookmark real sites: pmkisan.gov.in'**
  String get sim1_link_correctBody;

  /// No description provided for @sim1_link_wrongBody.
  ///
  /// In en, this message translates to:
  /// **'You chose a FAKE or shortened link!\n\nScammers use \'bit.ly\' or \'tinyurl\' to HIDE the real website.\n\nThe real PM Kisan site is:\nhttps://pmkisan.gov.in'**
  String get sim1_link_wrongBody;

  /// No description provided for @sim1_link_correctSpeak.
  ///
  /// In en, this message translates to:
  /// **'Correct! You chose the real government website. Always look for https and dot gov dot in.'**
  String get sim1_link_correctSpeak;

  /// No description provided for @sim1_link_wrongSpeak.
  ///
  /// In en, this message translates to:
  /// **'Wrong! You chose a fake link. Scammers use short links to hide the real website.'**
  String get sim1_link_wrongSpeak;

  /// No description provided for @sim1_link_tip.
  ///
  /// In en, this message translates to:
  /// **'Always check: https:// and .gov.in for Indian government websites'**
  String get sim1_link_tip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
