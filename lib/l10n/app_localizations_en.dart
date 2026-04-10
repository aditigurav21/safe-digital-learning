// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get sim1_intro_appBarTitle => 'Stay Safe Online';

  @override
  String get sim1_intro_heroTitle => 'Stay Safe from\nGovernment Scheme Scams';

  @override
  String get sim1_intro_heroSubtitle =>
      'Many fraud calls and messages target farmers.\nThis lesson will help you protect yourself.';

  @override
  String get sim1_intro_youWillLearn => 'You will learn:';

  @override
  String get sim1_intro_fakeLinksTitle => 'Fake links';

  @override
  String get sim1_intro_fakeLinksDesc =>
      'Bit.ly or unknown links are dangerous. Real sites end in .gov.in';

  @override
  String get sim1_intro_fakeOtpTitle => 'Fake OTP requests';

  @override
  String get sim1_intro_fakeOtpDesc =>
      'No government officer ever asks for OTP. That\'s a scam.';

  @override
  String get sim1_intro_safeInfoTitle => 'Safe information';

  @override
  String get sim1_intro_safeInfoDesc =>
      'Only share basic details — never passwords, PINs, or full bank info.';

  @override
  String get sim1_intro_urgencyTitle => 'Urgency tricks';

  @override
  String get sim1_intro_urgencyDesc =>
      'Scammers say \'Act now or lose money!\' — this is a trick to panic you.';

  @override
  String get sim1_intro_warningText =>
      'Never trust unknown links or urgent messages asking for money or OTP. When in doubt — CALL YOUR FAMILY FIRST.';

  @override
  String get sim1_intro_startBtn => 'Start Learning';

  @override
  String get sim1_form_appBarTitle => 'Scheme Application Form';

  @override
  String get sim1_form_scamAlert =>
      'SCAM ALERT: No government officer will call you after this form asking for OTP or money. If someone calls, IT IS A SCAM.';

  @override
  String get sim1_form_fullNameHint => 'e.g. Ramesh Kumar Sharma';

  @override
  String get sim1_form_fatherNameHint => 'e.g. Suresh Kumar Sharma';

  @override
  String get sim1_form_mobileHint => '10-digit mobile number';

  @override
  String get sim1_form_aadhaarLesson =>
      'LESSON: Enter Aadhaar ONLY on official .gov.in websites. This form is a simulation.';

  @override
  String get sim1_form_aadhaarHint => '12-digit Aadhaar number';

  @override
  String get sim1_form_aadhaarWarning =>
      'Real Aadhaar should only be entered on official government websites ending in .gov.in\n\nExample: https://pmkisan.gov.in\n\nNEVER share Aadhaar on unknown sites or WhatsApp.';

  @override
  String get sim1_form_bankLesson =>
      'LESSON: Bank details are needed for direct benefit transfer (DBT). Never share your bank PASSWORD or OTP — only account number is needed here.';

  @override
  String get sim1_form_bankHint => 'e.g. 12345678901234';

  @override
  String get sim1_form_bankWarning =>
      'Bank account number is used to send money directly to you (DBT).\n\nSafe to enter here.\nBUT: Never share your ATM PIN, internet banking password, or OTP.';

  @override
  String get sim1_form_ifscHint => 'e.g. SBIN0001234';

  @override
  String get sim1_form_villageHint => 'Your village or town name';

  @override
  String get sim1_form_declarationText =>
      'I hereby declare that the information provided in this form is true and correct to the best of my knowledge. I understand that providing false information may lead to cancellation of benefits and legal action under relevant laws.';

  @override
  String get sim1_form_declarationCheckbox =>
      'I have read and accept the above declaration.';

  @override
  String get sim1_form_submitBtn => 'Submit Application';

  @override
  String get sim1_form_submitting => 'Submitting...';

  @override
  String get sim1_form_footer =>
      'For help, call Kisan Helpline: 1800-180-1551 (Free)\nThis is a simulation. Not a real government website.';

  @override
  String get sim1_form_declarationRequired => 'Declaration Required';

  @override
  String get sim1_form_declarationRequiredMsg =>
      'Please read and accept the declaration at the bottom before submitting.';

  @override
  String get sim1_form_confirmTitle => 'Confirm Submission';

  @override
  String get sim1_form_confirmWarning =>
      '⚠ IMPORTANT: Real government websites NEVER ask for:\n• OTP over phone\n• Payment to process application\n• Password of any account\n\nThis is a SIMULATION to help you learn.';

  @override
  String get sim1_call_callerName => 'Gov Scheme Officer';

  @override
  String get sim1_call_callerNumber => '+91 98765 43210';

  @override
  String get sim1_call_unknownWarning => 'Unknown number — be careful!';

  @override
  String get sim1_call_slideHint => 'Slide to answer or decline';

  @override
  String get sim1_call_decline => 'Decline';

  @override
  String get sim1_call_accept => 'Accept';

  @override
  String get sim1_call_scammerSaying => 'Scammer is saying...';

  @override
  String get sim1_call_govNeverOtp =>
      'Government NEVER asks for OTP on a call. This is a scam.';

  @override
  String get sim1_call_whatWillYouDo => 'What will you do?';

  @override
  String get sim1_call_shareOtp => 'Share OTP';

  @override
  String get sim1_call_hangUp => 'Hang Up — Never Share OTP';

  @override
  String get sim1_otp_appBarTitle => 'OTP Verification';

  @override
  String get sim1_otp_submitBtn => 'Submit OTP';

  @override
  String get sim1_link_appBarTitle => 'Choose the Safe Website';

  @override
  String get sim1_link_question => 'Which website is SAFE to visit?';

  @override
  String get sim1_link_tapHint =>
      'Tap the one you think is the real government website.';

  @override
  String get sim1_link_fakeTitle => 'Quick Subsidy Portal';

  @override
  String get sim1_link_fakeUrl => 'http://bit.ly/kisan-help';

  @override
  String get sim1_link_tipHeader => 'How to check a safe website:';

  @override
  String get sim1_link_tip1 => 'Starts with https://';

  @override
  String get sim1_link_tip2 => 'Ends with .gov.in for Indian government';

  @override
  String get sim1_link_tip3 => 'Avoid bit.ly, tinyurl, or unknown names';

  @override
  String get sim1_link_tip4 =>
      'Avoid sites with spelling mistakes (e.g. \'g0v.in\')';

  @override
  String get sim1_link_correctTitle => 'Correct! ✅';

  @override
  String get sim1_link_wrongTitle => 'Wrong! ❌';

  @override
  String get sim1_success_appBarTitle => 'Simulation Result';

  @override
  String get sim1_success_stayedSafe => 'You Stayed Safe! 🎉';

  @override
  String get sim1_success_almostScammed => 'You Almost Got Scammed! ❌';

  @override
  String get sim1_success_safeMsg =>
      'Excellent! You made the right choice.\n\nYou checked the website carefully and avoided sharing sensitive information. This is exactly how you protect yourself from scammers.';

  @override
  String get sim1_success_scammedMsg =>
      'Don\'t worry — this is a simulation to help you learn.\n\nScammers use urgency, fake links, and fake calls to steal your money. Now you know their tricks. Next time you will catch it!';

  @override
  String get sim1_success_keyLearnings => 'Key Learnings:';

  @override
  String get sim1_success_learn1 => 'Never share OTP with anyone on phone';

  @override
  String get sim1_success_learn2 => 'Only visit websites ending in .gov.in';

  @override
  String get sim1_success_learn3 =>
      'Ignore \'URGENT\' messages — that is a panic trick';

  @override
  String get sim1_success_learn4 =>
      'If in doubt, call your family or 1930 helpline';

  @override
  String get sim1_success_learn5 =>
      'Government NEVER asks for money to give benefits';

  @override
  String get sim1_success_badgeSafe => 'Safe Choice';

  @override
  String get sim1_success_badgeRisky => 'Risky Choice';

  @override
  String get sim1_success_badgeLearn => 'Keep Learning';

  @override
  String get sim1_success_quizBtn => 'Take the Quiz';

  @override
  String get sim1_success_homeBtn => 'Go Home';

  @override
  String get sim1_common_iUnderstand => 'I Understand';

  @override
  String get sim1_quiz_correct => 'Correct! Well done.';

  @override
  String get sim1_result_appBarTitle => 'Quiz Result';

  @override
  String get sim1_result_rule1 => '1. 🔒  NEVER share OTP with anyone';

  @override
  String get sim1_result_rule2 => '2. 🌐  Only use .gov.in websites';

  @override
  String get sim1_result_rule3 => '3. 📞  Call 1930 if something feels wrong';

  @override
  String get sim1_result_rules => 'Remember these 3 rules:';

  @override
  String get sim1_result_homeBtn => 'Go Home';

  @override
  String get sim1_result_retryBtn => 'Retry Quiz';

  @override
  String get sim1_result_msg_perfect => 'Outstanding! You are a Scam Expert!';

  @override
  String get sim1_result_msg_great => 'Excellent! You are very aware of scams.';

  @override
  String get sim1_result_msg_good =>
      'Good! A little more practice and you will be a pro.';

  @override
  String get sim1_result_msg_keepGoing =>
      'Keep going! Scammers are tricky — practice more.';

  @override
  String get sim1_result_msg_tryAgain =>
      'Do not worry — now you know the tricks. Try again!';

  @override
  String get sim1_result_badge_gold => 'Gold Shield';

  @override
  String get sim1_result_badge_aware => 'Scam Aware';

  @override
  String get sim1_result_badge_learning => 'Learning';

  @override
  String get sim1_result_badge_practice => 'Needs Practice';

  @override
  String get sim1_result_badge_retry => 'Try Again';

  @override
  String get sim1_q1 =>
      'Someone calls and says \'Share your OTP to get your PM Kisan money\'. What should you do?';

  @override
  String get sim1_q1_opt1 => 'Share the OTP with them';

  @override
  String get sim1_q1_opt2 => 'Refuse and hang up — it is a scam';

  @override
  String get sim1_q1_opt3 => 'Share only if they say please';

  @override
  String get sim1_q2 => 'Which of these websites is SAFE for PM Kisan?';

  @override
  String get sim1_q2_opt1 => 'bit.ly/kisan-help';

  @override
  String get sim1_q2_opt2 => 'pmkisan-support.xyz';

  @override
  String get sim1_q2_opt3 => 'https://pmkisan.gov.in';

  @override
  String get sim1_q3 =>
      'You get a message: \'Pay ₹200 now or your scheme will be cancelled!\' What should you do?';

  @override
  String get sim1_q3_opt1 => 'Pay immediately';

  @override
  String get sim1_q3_opt2 => 'Ignore it and verify on the official website';

  @override
  String get sim1_q3_opt3 => 'Share your bank details';

  @override
  String get sim1_q4 =>
      'A WhatsApp message asks for your Aadhaar number for scheme benefit. Is this safe?';

  @override
  String get sim1_q4_opt1 => 'Yes, share it';

  @override
  String get sim1_q4_opt2 => 'No — never share Aadhaar on WhatsApp';

  @override
  String get sim1_q5 => 'Scammers send urgent messages because...?';

  @override
  String get sim1_q5_opt1 => 'They are very helpful people';

  @override
  String get sim1_q5_opt2 => 'Panic makes people act without thinking';

  @override
  String get sim1_q5_opt3 => 'They work for the government';

  @override
  String sim1_quiz_appBarTitle(int current, int total) {
    return 'Quiz — Question $current of $total';
  }

  @override
  String sim1_quiz_wrong(String answer) {
    return 'Wrong. The correct answer is: $answer';
  }

  @override
  String sim1_result_score(int score, int total) {
    return 'Your Score: $score / $total';
  }

  @override
  String sim1_result_scoreLabel(int score, int total) {
    return '$score out of $total correct';
  }

  @override
  String get sim1_common_continue => 'Continue';

  @override
  String get sim1_common_cancel => 'Cancel';

  @override
  String get sim1_common_understood => 'Understood';

  @override
  String get sim1_call_incomingCall => 'Incoming Call';

  @override
  String get sim1_call_callConnected => 'Call Connected';

  @override
  String get sim1_call_acceptOrDecline => 'Slide to answer or decline';

  @override
  String get sim1_call_scammerScript =>
      '\"Namaste ji! I am calling from PM Kisan office.\n\nYour ₹6000 payment is ready. Just share the OTP — right now — or the payment will be cancelled!\"';

  @override
  String get sim1_call_resultSafeTitle => 'Well Done! ✅';

  @override
  String get sim1_call_resultSafeBody =>
      'You made the RIGHT choice!\n\nReal government officers NEVER ask for OTP on a phone call.\n\nPM Kisan payments happen automatically — no OTP needed. Anyone asking for OTP is a SCAMMER.';

  @override
  String get sim1_call_resultSafeSpeak =>
      'Well done! You made the right choice. Real government officers never ask for OTP on a phone call.';

  @override
  String get sim1_call_resultWrongTitle => 'Oops! ❌';

  @override
  String get sim1_call_resultWrongBody =>
      'You fell for the scam!\n\nReal government officers NEVER ask for OTP.\n\nIf you share OTP, scammers can empty your bank account in minutes. Always hang up and call 1930 (Cyber Crime Helpline).';

  @override
  String get sim1_call_resultWrongSpeak =>
      'Oops! You fell for the scam. Real government officers never ask for OTP. Call 1930 if something feels wrong.';

  @override
  String get sim1_form_headerTitle =>
      'APPLICATION FOR GOVERNMENT SCHEME BENEFIT';

  @override
  String get sim1_form_appBarSub =>
      'Form No: GOI/AGRI/2024 | Simulation for learning only';

  @override
  String get sim1_form_partAHeader => 'Part A: Scheme Details';

  @override
  String get sim1_form_partBHeader => 'Part B: Personal Details';

  @override
  String get sim1_form_partCHeader => 'Part C: Identity Proof';

  @override
  String get sim1_form_partDHeader => 'Part D: Bank Account Details';

  @override
  String get sim1_form_partEHeader => 'Part E: Address Details';

  @override
  String get sim1_form_selectSchemeLabel => 'Select Scheme *';

  @override
  String get sim1_form_selectSchemeError => 'Please select a scheme';

  @override
  String get sim1_form_schemeList =>
      'PM Kisan Samman Nidhi,PM Fasal Bima Yojana,Pradhan Mantri Awas Yojana,PM Ujjwala Yojana,Ayushman Bharat';

  @override
  String get sim1_form_fullNameLabel => 'Full Name (As per Aadhaar) *';

  @override
  String get sim1_form_fullNameError => 'Enter your full name';

  @override
  String get sim1_form_fatherNameLabel => 'Father\'s / Husband\'s Name *';

  @override
  String get sim1_form_fatherNameError => 'Enter father/husband name';

  @override
  String get sim1_form_mobileLabel => 'Mobile Number (Linked to Aadhaar) *';

  @override
  String get sim1_form_mobileError => 'Enter valid 10-digit mobile number';

  @override
  String get sim1_form_aadhaarLabel => 'Aadhaar Number *';

  @override
  String get sim1_form_aadhaarError => 'Aadhaar must be 12 digits';

  @override
  String get sim1_form_bankLabel => 'Bank Account Number *';

  @override
  String get sim1_form_bankError => 'Enter valid account number';

  @override
  String get sim1_form_ifscLabel => 'IFSC Code *';

  @override
  String get sim1_form_ifscErrorEmpty => 'Enter IFSC code';

  @override
  String get sim1_form_ifscErrorInvalid => 'Invalid IFSC. Example: SBIN0001234';

  @override
  String get sim1_form_villageLabel => 'Village / Town / City *';

  @override
  String get sim1_form_villageError => 'Enter your village or town';

  @override
  String get sim1_form_stateLabel => 'State *';

  @override
  String get sim1_form_stateError => 'Please select your state';

  @override
  String get sim1_form_stateList =>
      'Andhra Pradesh,Arunachal Pradesh,Assam,Bihar,Chhattisgarh,Goa,Gujarat,Haryana,Himachal Pradesh,Jharkhand,Karnataka,Kerala,Madhya Pradesh,Maharashtra,Manipur,Meghalaya,Mizoram,Nagaland,Odisha,Punjab,Rajasthan,Sikkim,Tamil Nadu,Telangana,Tripura,Uttar Pradesh,Uttarakhand,West Bengal';

  @override
  String get sim1_form_declarationHeader => 'Declaration';

  @override
  String get sim1_form_declarationHint =>
      'Please read carefully before accepting';

  @override
  String get sim1_form_cautionTitle => 'Caution';

  @override
  String get sim1_form_confirmBody =>
      'You are about to submit your application.\n\n⚠ IMPORTANT: Real government websites NEVER ask for:\n• OTP over phone\n• Payment to process application\n• Password of any account\n\nThis is a SIMULATION to help you learn.';

  @override
  String get sim1_form_confirmSpeak =>
      'You are about to submit your application. Remember: real government websites never ask for OTP, payment, or passwords.';

  @override
  String get sim1_form_validationError =>
      '⚠ Please fill all required fields correctly.';

  @override
  String get sim1_form_simulationNote =>
      'This is a simulation. Not a real government website.';

  @override
  String get sim1_otp_title => 'Enter Your OTP';

  @override
  String get sim1_otp_subtitle => 'OTP sent to your registered mobile number';

  @override
  String get sim1_otp_fieldLabel => 'Enter 6-digit OTP';

  @override
  String get sim1_otp_warningText =>
      'Remember: NEVER share this OTP with anyone on phone — not even someone claiming to be from the government or bank.';

  @override
  String get sim1_otp_scamPopupTitle => 'Incoming Message! 🚨';

  @override
  String get sim1_otp_scamPopupBody =>
      '\"Namaste ji, I am messaging from PM Kisan Office.\n\nYour ₹6000 payment is ready. Please share the OTP you just received to confirm your identity.\"';

  @override
  String get sim1_otp_scamPopupQuestion => 'What will you do?';

  @override
  String get sim1_otp_scamPopupSpeak =>
      'Warning! Scam message received. Someone is asking for your OTP. Never share OTP with anyone.';

  @override
  String get sim1_otp_shareOtpBtn => 'Share OTP';

  @override
  String get sim1_otp_refuseBtn => 'Refuse & Block';

  @override
  String get sim1_otp_safeChoiceTitle => 'Great Choice! ✅';

  @override
  String get sim1_otp_safeChoiceBody =>
      'You are RIGHT to refuse!\n\nNo government officer EVER asks for OTP on phone or message.\n\nReal PM Kisan payments happen automatically — no OTP needed.\n\nIf someone asks for OTP, it is ALWAYS a scam. Block and call 1930.';

  @override
  String get sim1_otp_safeChoiceSpeak =>
      'Great choice! You refused to share the OTP. No government officer ever asks for OTP.';

  @override
  String get sim1_otp_submitDialogTitle => 'Wait! ⚠';

  @override
  String get sim1_otp_submitDialogBody =>
      'Did someone on the phone ask for this OTP?\n\nIf YES — that is a SCAM. Stop. Hang up.\n\nYou only enter OTP on the WEBSITE — never tell it to anyone.';

  @override
  String get sim1_otp_submitWarningSpeak =>
      'Wait! Did someone ask you for this OTP on the phone? If yes, that is a scam. Hang up immediately.';

  @override
  String get sim1_link_safeTitle => 'PM Kisan Official Website';

  @override
  String get sim1_link_safeUrl => 'https://pmkisan.gov.in';

  @override
  String get sim1_link_fakeExplanation =>
      '⚠ \'bit.ly\' hides the real link. \'http\' has no security. Avoid.';

  @override
  String get sim1_link_safeExplanation =>
      '✅ \'https\' = secure. \'.gov.in\' = real Indian government website.';

  @override
  String get sim1_link_correctBody =>
      'You chose the REAL government website!\n\nRemember:\n• \'https://\' = secure\n• \'.gov.in\' = official Indian government\n• Long, clear address = safe\n\nAlways bookmark real sites: pmkisan.gov.in';

  @override
  String get sim1_link_wrongBody =>
      'You chose a FAKE or shortened link!\n\nScammers use \'bit.ly\' or \'tinyurl\' to HIDE the real website.\n\nThe real PM Kisan site is:\nhttps://pmkisan.gov.in';

  @override
  String get sim1_link_correctSpeak =>
      'Correct! You chose the real government website. Always look for https and dot gov dot in.';

  @override
  String get sim1_link_wrongSpeak =>
      'Wrong! You chose a fake link. Scammers use short links to hide the real website.';

  @override
  String get sim1_link_tip =>
      'Always check: https:// and .gov.in for Indian government websites';
}
