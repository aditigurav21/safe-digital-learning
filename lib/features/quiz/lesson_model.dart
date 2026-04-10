class LessonPage {
  final String emoji;
  final String heading;
  final String body;
  final String? tip; // Optional highlighted tip box

  const LessonPage({
    required this.emoji,
    required this.heading,
    required this.body,
    this.tip,
  });
}

class QuizQuestion {
  final String scenario;       // The message/situation shown to user
  final String senderLabel;    // e.g. "Message from Unknown Number"
  final QuizAnswer answer;     // phishing, safe, or unsure_phishing
  final String explanation;    // Shown after answering — WHY it's phishing or safe
  final List<String> redFlags; // Bullet points of warning signs (empty if safe)

  const QuizQuestion({
    required this.scenario,
    required this.senderLabel,
    required this.answer,
    required this.explanation,
    this.redFlags = const [],
  });
}

enum QuizAnswer { phishing, safe, couldBePhishing }

class LevelData {
  final int level;
  final String emoji;
  final String title;
  final String subtitle;
  final String description;
  final List<LessonPage> lessonPages;
  final List<QuizQuestion> questions;

  const LevelData({
    required this.level,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.lessonPages,
    required this.questions,
  });
}

// ─────────────────────────────────────────────
// LEVEL CONTENT
// ─────────────────────────────────────────────

const List<LevelData> allLevels = [
  // ─── LEVEL 1: Password & OTP Safety ──────────
  LevelData(
    level: 1,
    emoji: '🔐',
    title: 'Password & OTP Safety',
    subtitle: 'Protect your accounts',
    description: 'Learn how to keep your passwords and OTPs safe from fraudsters.',
    lessonPages: [
      LessonPage(
        emoji: '🔑',
        heading: 'What is a Password?',
        body:
            'A password is a secret word or number that only you know. It lets you log in to your bank, email, or mobile apps.\n\nJust like the key to your house, your password should be kept secret.',
        tip: '✅ Never share your password with anyone — not even your bank!',
      ),
      LessonPage(
        emoji: '📱',
        heading: 'What is an OTP?',
        body:
            'OTP stands for One Time Password. It is a 4 or 6 digit number sent to your phone by SMS when you log in or make a payment.\n\nIt is only valid for a few minutes. After that, it expires.',
        tip: '⚠️ Your bank will NEVER call you and ask for your OTP.',
      ),
      LessonPage(
        emoji: '🎭',
        heading: 'How Fraudsters Trick You',
        body:
            'Fraudsters pretend to be bank staff, government officers, or "customer care" agents. They call you and say:\n\n• "Your account is blocked — share your OTP to unblock it."\n• "You have won a prize — share your OTP to claim it."\n• "We need to verify you — tell us your password."\n\nAll of these are LIES.',
        tip: '🚫 No real bank or government office ever asks for your OTP or password.',
      ),
      LessonPage(
        emoji: '💪',
        heading: 'Make a Strong Password',
        body:
            'A strong password:\n\n✅ Is at least 8 characters long\n✅ Has a mix of letters and numbers\n✅ Is different for each app\n\nA weak password:\n\n❌ Is your name or birthday (e.g. "Ram1960")\n❌ Is "1234" or "0000"\n❌ Is the same for all apps',
        tip: '💡 Example of a strong password: Blue@Sky75',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'Phone call — "Bank of India Customer Care"',
        scenario:
            '"Hello, I am calling from Bank of India. Your account has been blocked due to a security issue. To unblock it immediately, please share the OTP that has just been sent to your phone."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a SCAM call. Real banks NEVER call you and ask for your OTP. The fraudster wants your OTP to steal money from your account. Hang up immediately.',
        redFlags: [
          'Banks never ask for OTP on a call',
          'Urgency ("immediately") is a pressure trick',
          'The "blocked account" story is very common fraud',
        ],
      ),
      QuizQuestion(
        senderLabel: 'SMS from AD-SBIBNK',
        scenario:
            '"Your SBI account password has been changed. If you did not do this, call our helpline at 1800-111-2222 immediately."',
        answer: QuizAnswer.safe,
        explanation:
            'This type of alert SMS from your bank is normal and safe. It is telling you about a change on your account. The helpline number 1800-XXXXXX is a real bank number. If you did NOT change your password, do call your bank immediately.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'WhatsApp message from +91-98XXXXXXXX (unknown)',
        scenario:
            '"Congratulations! You have won ₹50,000 in the SBI Lucky Draw! To receive your prize, share your ATM PIN and OTP with our agent."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is definitely a scam. No bank or lottery asks for your ATM PIN or OTP to send you prize money. This person wants to empty your bank account.',
        redFlags: [
          'Unknown WhatsApp number — not an official bank contact',
          'Asking for ATM PIN — banks NEVER do this',
          'Prize money via OTP is always fraud',
          '"Lucky draw" without you entering any contest',
        ],
      ),
      QuizQuestion(
        senderLabel: 'SMS from AD-HDFCBK',
        scenario:
            '"HDFC Bank: ₹5,000 debited from your account ending 4321 at Reliance Mart on 08-Apr. Available balance: ₹12,400. Helpline: 1800-202-6161."',
        answer: QuizAnswer.safe,
        explanation:
            'This is a genuine transaction alert from HDFC Bank. Banks send these automatically when money is spent. It does not ask you to do anything — just informs you. This is completely safe.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Phone call — "Income Tax Department"',
        scenario:
            '"This is the Income Tax Department. We have found tax fraud in your name. You must pay ₹8,000 in the next 2 hours or police will arrive. Share your UPI PIN to pay the fine now."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a very common scam targeting elderly people. The Income Tax Department NEVER calls and demands immediate payment via UPI PIN. Government offices send written notices. UPI PINs are never shared with anyone.',
        redFlags: [
          'Government offices never demand payment over a phone call',
          'Threat of police is a fear tactic to make you panic',
          'Only 2-hour deadline — designed to stop you from thinking',
          'UPI PIN is secret — never share it',
        ],
      ),
    ],
  ),

  // ─── LEVEL 2: Phishing Messages & Fake Links ─
  LevelData(
    level: 2,
    emoji: '🎣',
    title: 'Phishing Messages',
    subtitle: 'Spot fake SMS and emails',
    description: 'Learn to spot fake messages and dangerous links sent by fraudsters.',
    lessonPages: [
      LessonPage(
        emoji: '🎣',
        heading: 'What is Phishing?',
        body:
            'Phishing means a fraudster sends you a fake message pretending to be a trusted company — like your bank, Amazon, or the government.\n\nThey want you to click a link and enter your personal information on a fake website.',
        tip: '⚠️ "Phishing" sounds like "fishing" — they are fishing for your information!',
      ),
      LessonPage(
        emoji: '🔗',
        heading: 'Spot a Fake Link (URL)',
        body:
            'A real bank website looks like:\n🟢 https://www.sbi.co.in\n🟢 https://www.hdfcbank.com\n\nA fake website looks like:\n🔴 http://sbi-alert-login.com\n🔴 https://hdfcbank.secure-update.xyz\n🔴 https://bit.ly/SBIkycUpdate\n\nTrick: If it has extra words like "alert", "secure", "update", or random letters — it is fake.',
        tip: '💡 Always type your bank\'s website address yourself. Never click a link in an SMS.',
      ),
      LessonPage(
        emoji: '📨',
        heading: 'Signs of a Fake Message',
        body:
            'Watch out for messages that:\n\n❌ Say "Your account will be closed today"\n❌ Offer free money or prizes\n❌ Ask you to "click here" to update KYC\n❌ Come from unknown numbers (not "AD-SBIBNK")\n❌ Have spelling mistakes\n❌ Feel too urgent or scary',
        tip: '✅ Real banks send messages from short sender IDs like AD-SBIBNK, not phone numbers.',
      ),
      LessonPage(
        emoji: '🛑',
        heading: 'What to Do If You Get a Fake Message',
        body:
            'If you receive a suspicious message:\n\n1. DO NOT click any link\n2. DO NOT call the number in the message\n3. Call your bank\'s official number (printed on your card)\n4. Report it to the Cyber Crime helpline: 1930\n5. Block and delete the message',
        tip: '📞 India Cyber Crime Helpline: 1930 (free, available 24×7)',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'SMS from +91-8876543210',
        scenario:
            '"URGENT: Your SBI KYC is incomplete. Your account will be BLOCKED in 24 hours. Update now: http://sbi-kyc-update.in/click"',
        answer: QuizAnswer.phishing,
        explanation:
            'This is phishing. Real SBI messages come from "AD-SBIBNK", not a mobile number. The link "sbi-kyc-update.in" is a fake website designed to steal your login details. Your bank will never block your account with just 24 hours notice via SMS.',
        redFlags: [
          'Sent from a mobile number, not a bank sender ID',
          'Fake-looking link with "kyc-update" in the URL',
          'Urgent 24-hour threat to panic you',
          'Asks you to click — banks never update KYC via SMS link',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Email from noreply@amazon.in',
        scenario:
            '"Your Amazon order #302-1234567 has been dispatched. Expected delivery: 10 April. Track your order at amazon.in/track. For help, call 1800-419-7355."',
        answer: QuizAnswer.safe,
        explanation:
            'This looks like a genuine Amazon order update. The sender is "@amazon.in" (the real Amazon India domain), the link goes to "amazon.in" (not a fake domain), and it does not ask you to share any personal information. This type of email is safe.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'WhatsApp message — unknown number',
        scenario:
            '"Your IRCTC account has been suspended. Click here to reactivate: http://bit.ly/irctc-reactivate2024. Failure to act will result in permanent ban."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is phishing. IRCTC never sends account suspension notices via WhatsApp from unknown numbers. The link uses "bit.ly" which hides the real destination — a common trick used by scammers. Never click shortened links from unknown senders.',
        redFlags: [
          'IRCTC does not use WhatsApp for official notices',
          '"bit.ly" link hides the real website',
          '"Permanent ban" threat to create panic',
          'Unknown sender number',
        ],
      ),
      QuizQuestion(
        senderLabel: 'SMS from AD-PAYTMB',
        scenario:
            '"Your Paytm UPI transaction of ₹299 to ZOMATO is successful. UPI Ref: 412348765. Balance: ₹1,840. For disputes, call 01204456456."',
        answer: QuizAnswer.safe,
        explanation:
            'This is a genuine Paytm transaction alert. It comes from "AD-PAYTMB" (official Paytm sender ID), shows your transaction details clearly, and only gives you a helpline number — it does not ask for any information from you.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'SMS from VM-PMKISN',
        scenario:
            '"PM Kisan Samman Nidhi: ₹2,000 is ready for your account. To receive, click and verify your Aadhaar: http://pmkisan-verify.co/aadhaar"',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a scam targeting farmers. The real PM Kisan scheme deposits money directly to your bank without asking you to verify Aadhaar via SMS link. The link "pmkisan-verify.co" is not a government website (government sites end in .gov.in). Never enter your Aadhaar on such links.',
        redFlags: [
          'Government schemes never require link-click to receive money',
          'Domain is ".co" not ".gov.in"',
          '"pmkisan-verify" is not an official government domain',
          'Asking for Aadhaar details is a data theft attempt',
        ],
      ),
    ],
  ),

  // ─── NEW LEVEL 3: Insurance Scams ────────────
LevelData(
  level: 3,
  emoji: '🛡️',
  title: 'Insurance Scams',
  subtitle: 'Fake policies & claim fraud',
  description: 'Learn how fraudsters trick people using fake insurance calls, policies, and claims.',
  lessonPages: [
    LessonPage(
      emoji: '🧾',
      heading: 'What is Insurance?',
      body:
          'Insurance protects you from financial loss. You pay a premium, and the company helps you during emergencies like accidents, health issues, or damage.\n\nBut scammers misuse this concept to trick people.',
      tip: '✅ Always buy insurance from official company websites or agents.',
    ),
    LessonPage(
      emoji: '📞',
      heading: 'Fake Insurance Calls',
      body:
          'Fraudsters call pretending to be from LIC, SBI Life, or other insurance companies.\n\nThey say:\n• "Your old policy has matured — pay fee to receive money"\n• "Update your policy KYC now"\n• "You will get bonus if you invest now"\n\nThese are scams.',
      tip: '⚠️ Real insurance companies NEVER ask for payment to release maturity money.',
    ),
    LessonPage(
      emoji: '💰',
      heading: 'Fake Policy & Bonus Scam',
      body:
          'Scammers offer fake insurance policies with high returns.\n\nThey promise:\n• Double money in short time\n• Huge bonus on policy\n• Special scheme only for you\n\nAfter payment, they disappear.',
      tip: '🚫 Insurance is NOT for quick profit. High return = high risk scam.',
    ),
    LessonPage(
      emoji: '🛑',
      heading: 'How to Stay Safe',
      body:
          'To stay safe:\n\n1. Do not trust unknown calls\n2. Verify policy on official website\n3. Never share PAN, Aadhaar, or bank details\n4. Call company helpline yourself\n5. Report fraud to 1930',
      tip: '📞 Always verify before paying any insurance-related amount.',
    ),
  ],
  questions: [
    QuizQuestion(
      senderLabel: 'Phone call — "LIC Agent"',
      scenario:
          '"Your LIC policy has matured. You will receive ₹2 lakh. To release it, pay ₹5,000 processing fee now."',
      answer: QuizAnswer.phishing,
      explanation:
          'This is a scam. Insurance companies never ask for fees to release maturity money. The caller is trying to steal your money.',
      redFlags: [
        'Asking for payment to release money',
        'Urgency to pay immediately',
        'Unverified caller',
      ],
    ),
    QuizQuestion(
      senderLabel: 'SMS from unknown number',
      scenario:
          '"Special insurance scheme! Invest ₹10,000 and get ₹50,000 in 30 days. Call now!"',
      answer: QuizAnswer.phishing,
      explanation:
          'This is fake. Insurance does not give quick returns. This is a trap to steal your money.',
      redFlags: [
        'Unrealistic returns',
        'Unknown sender',
        'Too good to be true',
      ],
    ),
    QuizQuestion(
      senderLabel: 'Official email from LIC',
      scenario:
          '"Your LIC premium of ₹2,000 is due. Please pay via official website licindia.in"',
      answer: QuizAnswer.safe,
      explanation:
          'This is normal. It asks you to pay through official LIC website and does not request sensitive data.',
      redFlags: [],
    ),
    QuizQuestion(
      senderLabel: 'Phone call — unknown number',
      scenario:
          '"Your insurance KYC is pending. Share your Aadhaar and bank details to update now."',
      answer: QuizAnswer.phishing,
      explanation:
          'This is a scam. No company asks for full Aadhaar and bank details over phone.',
      redFlags: [
        'Asking sensitive information',
        'Unknown caller',
        'KYC pressure tactic',
      ],
    ),
    QuizQuestion(
      senderLabel: 'Insurance agent visit',
      scenario:
          'An agent visits your home, shows ID card, explains policy, and asks you to verify details on official app before payment.',
      answer: QuizAnswer.safe,
      explanation:
          'This is safe because the agent is verified and asks you to confirm through official channels.',
      redFlags: [],
    ),
  ],
),

  // ─── LEVEL 4: Fraudulent Websites ────────────
  LevelData(
    level: 4,
    emoji: '🌐',
    title: 'Spotting Fake Websites',
    subtitle: 'Is this website real or fake?',
    description: 'Learn to tell the difference between real and fraudulent websites.',
    lessonPages: [
      LessonPage(
        emoji: '🔒',
        heading: 'The Padlock and HTTPS',
        body:
            'When you visit a website, look at the top of your browser:\n\n🟢 HTTPS + 🔒 padlock = more secure\n🔴 HTTP (no S, no padlock) = NOT secure\n\nBUT: Even a fake website can have HTTPS! The padlock only means the connection is encrypted — it does NOT guarantee the site is real.',
        tip: '✅ HTTPS is necessary but not enough. Always check the full website address.',
      ),
      LessonPage(
        emoji: '🔍',
        heading: 'How to Read a Website Address',
        body:
            'The website address (URL) is the key. Look at the part just BEFORE ".com" or ".in":\n\n🟢 sbi.co.in → Real SBI website\n🟢 hdfcbank.com → Real HDFC Bank\n\n🔴 sbi.co.in.secure-login.com → FAKE (the real part is "secure-login.com")\n🔴 hdfc-bank-update.net → FAKE\n🔴 onlinesbi.co.in.login123.xyz → FAKE',
        tip: '💡 Trick: Look at the last word before the first "/" — that is the real domain.',
      ),
      LessonPage(
        emoji: '⚠️',
        heading: 'Other Warning Signs on Websites',
        body:
            'Signs that a website may be fake:\n\n❌ Lots of spelling mistakes\n❌ Asks for your ATM PIN or OTP on the website\n❌ Offers too-good-to-be-true deals\n❌ Has a strange web address\n❌ Asks for your Aadhaar number to "verify" something\n❌ Pop-up saying "You have won!"',
        tip: '🛑 If a website asks for your OTP or PIN — LEAVE immediately.',
      ),
      LessonPage(
        emoji: '🏦',
        heading: 'Safe Way to Visit Your Bank',
        body:
            'The safest ways to access your bank:\n\n1. ✅ Type the address yourself in the browser\n2. ✅ Use your bank\'s official app (downloaded from Play Store/App Store)\n3. ✅ Call the number on your ATM card\n\nNEVER:\n❌ Click a link in an SMS to visit your bank\n❌ Search "SBI login" on Google and click the first result\n❌ Use public Wi-Fi for banking',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'Website address in your browser',
        scenario:
            'You want to check your HDFC Bank balance. You search Google and click the first result. The browser shows:\n\nhttp://hdfcbank.secure-login-india.com/netbanking\n\nIs this the real HDFC Bank website?',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a FAKE website. The real HDFC Bank website is "hdfcbank.com". In this URL, the actual domain is "secure-login-india.com" — HDFC is just added at the beginning to trick you. Also notice "http" (no "s") — not secure. Never search for bank websites on Google; type the address yourself.',
        redFlags: [
          'Real domain is "secure-login-india.com", not "hdfcbank.com"',
          'Uses http not https',
          'Google search results can include fake websites in ads',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Website address in your browser',
        scenario:
            'You open your browser and type: https://www.onlinesbi.sbi\n\nThe padlock icon is showing. The page looks exactly like SBI\'s website. Is this real?',
        answer: QuizAnswer.safe,
        explanation:
            'Yes, this is the real SBI Online Banking website. "onlinesbi.sbi" is SBI\'s official domain (the .sbi extension is exclusively owned by State Bank of India). You typed it yourself (not clicked a link), and HTTPS with a padlock is present. This is safe.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Website pop-up',
        scenario:
            'While browsing a recipe website, a big pop-up appears:\n\n"🎉 CONGRATULATIONS! You are our 1,000,000th visitor! You have won a Samsung TV! Click CLAIM NOW and enter your Aadhaar and bank details to receive your prize."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a classic online scam. You cannot win a TV just by visiting a website. This pop-up wants to steal your Aadhaar number and bank details. Close this pop-up immediately. Never enter personal information on such pop-ups.',
        redFlags: [
          'Nobody wins prizes just by visiting a website',
          'Asking for Aadhaar and bank details together is a red flag',
          'Sudden pop-ups on unrelated websites are almost always scams',
          'Too good to be true = always suspicious',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Website address in your browser',
        scenario:
            'You scan a QR code at a government office. The browser opens:\n\nhttps://services.india.gov.in/service/detail/apply-ration-card\n\nIs this a safe government website?',
        answer: QuizAnswer.safe,
        explanation:
            'This is a safe government website. All Indian government websites end in ".gov.in" — this is a domain that only the government can use. The website uses HTTPS. And you scanned it at a real government office. This is legitimate.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Website shown in a Facebook ad',
        scenario:
            'You see a Facebook ad: "Apply for PM Awas Yojana — get ₹2.5 lakh subsidy! Limited time!" The link goes to:\n\nhttp://pmawas-yojana-apply.in/register\n\nShould you fill in your details?',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a fraud website. Real government schemes are applied through official portals ending in ".gov.in" (like pmaymis.gov.in). This site uses ".in" domain (not ".gov.in"), has "http" (not secure), and was advertised on Facebook — government schemes do not run Facebook ads. Your data will be stolen.',
        redFlags: [
          'Domain is ".in" not ".gov.in"',
          'Uses http, not https',
          'Government schemes do not advertise on Facebook',
          '"Limited time" is a pressure tactic',
        ],
      ),
    ],
  ),

  // ─── LEVEL 5: Spam Calls & AI Voice Cloning ──
  LevelData(
    level: 5,
    emoji: '📞',
    title: 'Spam Calls & Fake Voices',
    subtitle: 'AI voice cloning and call fraud',
    description:
        'Learn about spam calls, fake caller IDs, and the new danger of AI-generated voices.',
    lessonPages: [
      LessonPage(
        emoji: '📞',
        heading: 'Spam and Scam Calls',
        body:
            'Every day, millions of people receive spam calls pretending to be:\n\n• Bank customer care\n• Income Tax / GST department\n• Police or court officials\n• TRAI (telecom authority)\n• Lottery or prize companies\n\nThey use fear or excitement to trick you into sharing information or sending money.',
        tip: '✅ Add your number to DND (Do Not Disturb) registry at trai.gov.in to reduce spam calls.',
      ),
      LessonPage(
        emoji: '🎭',
        heading: 'Fake Caller ID (Spoofing)',
        body:
            'Fraudsters can make their call appear from ANY number — even your bank\'s official number!\n\nThis is called "caller ID spoofing". So even if the phone shows "SBI Bank" or "+91-80-XXXXXXX", the call might be a scammer.',
        tip: '⚠️ Never trust the number shown on your screen. Hang up and call back on the official number you find on the bank\'s website.',
      ),
      LessonPage(
        emoji: '🤖',
        heading: 'AI Voice Cloning — The New Danger',
        body:
            'Criminals can now use Artificial Intelligence (AI) to copy someone\'s voice. They record just 10–30 seconds of a person speaking (from a video or voice message) and create a fake voice that sounds exactly like that person.\n\nYou might get a call that sounds like your son, daughter, or friend — but it is an AI robot!',
        tip: '🔴 AI voice calls are already happening in India. Be very careful.',
      ),
      LessonPage(
        emoji: '🛡️',
        heading: 'Protect Yourself from Voice Cloning',
        body:
            'If you get an urgent call from a "family member" asking for money:\n\n1. Stay calm — do not panic\n2. Hang up\n3. Call your family member back on their real number\n4. Set a secret "family code word" that only your family knows\n5. Never send money based on a single phone call\n\nIf the voice is AI, it will not know your secret family code word.',
        tip: '💡 Create a family code word today. Share it only with your immediate family.',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'Phone call — Caller ID shows "TRAI Official"',
        scenario:
            '"Hello, this is TRAI. Your mobile number will be disconnected in 2 hours due to illegal use. To avoid disconnection, press 9 to speak to our officer and verify your Aadhaar."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is one of the most common scam calls in India. TRAI (Telecom Regulatory Authority of India) does NOT call people to disconnect numbers. They do not ask for Aadhaar verification over phone. The caller ID can be spoofed to show "TRAI". Press nothing — hang up.',
        redFlags: [
          'TRAI does not call individuals to warn about disconnection',
          'Asking to press 9 connects you to a scam call center',
          'Caller ID showing "TRAI Official" could be spoofed',
          'Aadhaar verification is never done over a phone call',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Video call from your nephew\'s number',
        scenario:
            'Your nephew calls you on video. He looks and sounds exactly like himself. He says he is fine and asks if you received the Diwali sweets he sent. It is a normal family chat.',
        answer: QuizAnswer.safe,
        explanation:
            'A normal family video call where the person looks and sounds real, is not asking for money or personal details, and is making normal conversation is safe. Video calls showing the real face are harder to fake than audio-only AI cloning. This is a legitimate call.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Voice call — sounds like your son',
        scenario:
            'You get a call. The voice sounds EXACTLY like your son. He says: "Amma, I have had an accident. I am at the police station. Please urgently send ₹15,000 to this number via GPay. I will explain later. Don\'t call me back — my phone battery is low."',
        answer: QuizAnswer.phishing,
        explanation:
            'This is an AI voice cloning scam. Criminals cloned your son\'s voice from a video or voice message. The signs: urgent money request, asks you not to call back (so you can\'t verify), no time to think. Always call your son on his real number before sending any money. Never send money based on one call.',
        redFlags: [
          'Urgency and panic — designed to stop you thinking',
          '"Don\'t call back" — prevents you from verifying',
          'AI can clone voices from just 10 seconds of audio',
          'Emergency money requests via phone are a classic scam pattern',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Call from 1800-180-1111',
        scenario:
            '"This is the Employees\' Provident Fund Organisation (EPFO). Your PF amount of ₹45,000 is pending. To receive it, please confirm your Aadhaar number and bank account number on this call."',
        answer: QuizAnswer.phishing,
        explanation:
            'EPFO does not call you to transfer PF money. PF is claimed through official applications on the EPFO portal or through your employer. Giving your Aadhaar and bank account number on a random call is very dangerous. Call 1800-118-005 (real EPFO helpline) to check your PF status yourself.',
        redFlags: [
          'EPFO does not initiate calls to transfer money',
          'Asking for Aadhaar + bank account = identity theft attempt',
          'Check PF yourself on epfindia.gov.in or call real helpline',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Call from your bank\'s official number',
        scenario:
            'Your phone shows a call from "HDFC Bank — 1800 202 6161" (the real HDFC helpline number). The caller says your account is flagged and asks you to confirm your last 4 card digits and the OTP just sent to you.',
        answer: QuizAnswer.couldBePhishing,
        explanation:
            'Even though the caller ID shows the real HDFC number, this could be caller ID spoofing. Real banks never ask for OTP on a call. The safest thing: hang up, then call 1800 202 6161 yourself to verify. If it was a real issue, the bank will tell you when you call them back.',
        redFlags: [
          'Caller ID can be spoofed — even official bank numbers',
          'Banks NEVER ask for OTP over the phone',
          'Always hang up and call the bank yourself to verify',
        ],
      ),
    ],
  ),

  // ─── LEVEL 6: Deepfakes & Advanced Scams ─────
  LevelData(
    level: 6,
    emoji: '🏆',
    title: 'Deepfakes & Advanced Scams',
    subtitle: 'The master challenge',
    description:
        'Test your knowledge on deepfakes, malicious links, and the most sophisticated digital scams.',
    lessonPages: [
      LessonPage(
        emoji: '🎬',
        heading: 'What is a Deepfake?',
        body:
            'A deepfake is an AI-generated fake video or photo. Someone\'s face is placed on another person\'s body, or a person is made to say things they never said.\n\nDeepfakes are used to:\n• Spread false news about politicians\n• Create fake celebrity endorsements for scam investments\n• Make it look like a relative is in trouble',
        tip: '🔴 If a video seems shocking or unbelievable — it might be a deepfake.',
      ),
      LessonPage(
        emoji: '📹',
        heading: 'How to Spot a Deepfake Video',
        body:
            'Signs a video might be a deepfake:\n\n❌ The face looks slightly blurry or "melting" at edges\n❌ Eyes don\'t blink naturally\n❌ Lip movement doesn\'t match the words\n❌ Lighting on the face doesn\'t match the background\n❌ The person says things they would never say\n\nWhen in doubt — do not believe, share, or act on such videos.',
        tip: '✅ Verify shocking videos on fact-check sites like boomlive.in or altnews.in',
      ),
      LessonPage(
        emoji: '💰',
        heading: 'Investment Scams Using Deepfakes',
        body:
            'Scammers create deepfake videos of famous people — like Mukesh Ambani, Narendra Modi, or Ratan Tata — claiming they have a special investment scheme.\n\nThe video looks very real. The celebrity appears to say: "Invest ₹10,000 and earn ₹1 lakh in 30 days!"\n\nThis is ALWAYS a scam. No celebrity runs secret investment schemes.',
        tip: '📞 If you see such a video, report it on cybercrime.gov.in',
      ),
      LessonPage(
        emoji: '🦠',
        heading: 'Malicious Links and App Downloads',
        body:
            'Fraudsters send links that, when clicked, install harmful software (malware) on your phone. This malware can:\n\n• Read your bank OTPs automatically\n• Record your screen or keystrokes\n• Access your contacts and photos\n• Lock your phone and demand money (ransomware)\n\nOnly install apps from the official Play Store or App Store. Never install an APK file sent via WhatsApp.',
        tip: '🚫 Never install an app that someone sends you via WhatsApp or SMS link.',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'WhatsApp video — forwarded by a friend',
        scenario:
            'Your friend forwards a video. It shows Mukesh Ambani saying: "Due to Reliance\'s 50th anniversary, we are giving ₹50 lakh to 100 lucky customers. Click the link to register: reliance-lucky50.com"',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a deepfake video scam. The video of Mukesh Ambani is AI-generated. Reliance Industries would never run a lottery scheme through a WhatsApp video. The link "reliance-lucky50.com" is a fraud website. Do not click and do not forward this to others.',
        redFlags: [
          'Real companies do not announce schemes via WhatsApp videos',
          'Deepfake celebrity videos are very common for investment scams',
          '"reliance-lucky50.com" is not an official Reliance website',
          'Your friend forwarded it unknowingly — does not make it safe',
        ],
      ),
      QuizQuestion(
        senderLabel: 'WhatsApp message — unknown number',
        scenario:
            '"Hello! I am Sharma ji\'s relative. Please install this app to join our community group: [Download App.apk]"',
        answer: QuizAnswer.phishing,
        explanation:
            'Never install an APK file sent via WhatsApp. APK files are app installation files. When sent by strangers, they almost always contain malware that can steal your banking details, read your OTPs, or lock your phone. Real community groups are joined through the Play Store.',
        redFlags: [
          'APK files from unknown people = very dangerous malware',
          'You do not know "Sharma ji\'s relative"',
          'Legitimate apps are on Play Store, not WhatsApp',
          'Malware can silently read your OTPs and send them to fraudsters',
        ],
      ),
      QuizQuestion(
        senderLabel: 'YouTube video ad — verified channel',
        scenario:
            'Before a YouTube video, an ad plays. It shows PM Modi speaking about a new government scheme for senior citizens — ₹5,000/month pension. The YouTube channel has a blue tick. It asks you to apply on a website.',
        answer: QuizAnswer.couldBePhishing,
        explanation:
            'Even verified YouTube channels can be hacked and used to run deepfake ads. PM Modi deepfake videos have been used for scams before. Before applying on any website, verify the scheme on mygov.in or pmindia.gov.in. If the website is not ".gov.in", do not enter any details.',
        redFlags: [
          'Deepfake videos of PM Modi have been used in previous scams',
          'YouTube verification does not guarantee the channel is uncompromised',
          'Verify any scheme on official .gov.in websites before acting',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Official email from cybercrime.gov.in',
        scenario:
            'You receive an email from "noreply@cybercrime.gov.in". It says:\n\n"Your complaint #CY2024/8876 has been registered. You will be contacted within 7 working days."',
        answer: QuizAnswer.safe,
        explanation:
            'An automated confirmation email from cybercrime.gov.in after you have filed a complaint is genuine. The domain "@cybercrime.gov.in" is the official Indian government cybercrime portal. This email just confirms your complaint — it asks nothing from you.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Facebook message from "friend"',
        scenario:
            '"Hey! I am stuck in Dubai. My wallet was stolen. Can you urgently send ₹20,000 to this account? I will return it in 2 days. Please don\'t tell anyone — very embarrassing." — [Your Friend\'s Name]',
        answer: QuizAnswer.phishing,
        explanation:
            'This is a very common scam — the friend\'s Facebook account was hacked. The hacker is messaging all their contacts asking for money. "Don\'t tell anyone" is designed to stop you from verifying. Always call your friend on their real phone number before sending any money. This scam has cheated many people.',
        redFlags: [
          'Facebook accounts get hacked and used to scam friends',
          '"Don\'t tell anyone" prevents you from checking with others',
          'Always verify by calling the person on their actual number',
          'No genuine friend would ask you not to tell anyone',
        ],
      ),
    ],
  ),
];