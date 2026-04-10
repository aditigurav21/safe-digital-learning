// ignore_for_file: constant_identifier_names
import 'topic_animation_screen.dart';

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

  // ── NEW: which animated lesson plays before the quiz ──────────
  // Defaults to null — if null, the animation screen is skipped
  // and the quiz starts directly (backward-compatible).
  final AnimationTopic? animationKey;

  const LevelData({
    required this.level,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.lessonPages,
    required this.questions,
    this.animationKey, // optional — existing code won't break
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
    animationKey: AnimationTopic.banking, // ← OTP / banking animation
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
        'The Income Tax Department NEVER calls to demand instant payment. They send official letters. UPI PIN is your private secret — never share it. This is a very common government impersonation scam.',
        redFlags: [
          'Government agencies send letters — not panic phone calls',
          'Threat of police arrest is a pressure tactic',
          'UPI PIN should never be shared with anyone',
          '"Pay in 2 hours" creates panic so you don\'t think clearly',
        ],
      ),
    ],
  ),

  // ─── LEVEL 2: Phishing Messages ──────────────
  LevelData(
    level: 2,
    emoji: '🎣',
    title: 'Phishing Messages',
    subtitle: 'Spot fake SMS & WhatsApp',
    description: 'Learn to identify fake messages that try to steal your information.',
    animationKey: AnimationTopic.phishing, // ← phishing animation
    lessonPages: [
      LessonPage(
        emoji: '🎣',
        heading: 'What is Phishing?',
        body:
        'Phishing is when a criminal sends you a fake message pretending to be from your bank, government, or a trusted company.\n\nThe goal is to trick you into:\n• Clicking a dangerous link\n• Sharing your password or OTP\n• Calling a fake helpline number',
        tip: '🔴 If a message creates fear or excitement — stop and think before reacting.',
      ),
      LessonPage(
        emoji: '🔍',
        heading: 'Red Flags in Messages',
        body:
        'Watch out for these warning signs:\n\n🚩 "Urgent!" or "Act now!" language\n🚩 Spelling mistakes in the sender\'s name\n🚩 Links that look almost-right (e.g. "SB1.com" instead of "SBI.com")\n🚩 Asking for your PIN, OTP, or Aadhaar\n🚩 Winning a prize you never entered',
        tip: '✅ Real banks and government offices NEVER ask for personal details over SMS.',
      ),
      LessonPage(
        emoji: '📲',
        heading: 'Fake Links',
        body:
        'Scammers create websites that look exactly like real ones.\n\nHow to spot a fake link:\n\n❌ http:// instead of https://\n❌ Extra words: "sbi-secure-login.com"\n❌ Wrong ending: ".net" instead of ".co.in"\n❌ Numbers in place of letters: "sb1" not "sbi"\n\nWhen in doubt — do NOT click. Open your bank app directly.',
        tip: '🔒 Look for the padlock (🔒) in the browser before entering any details.',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'SMS from VM-ICICIB',
        scenario:
        '"ICICI Bank: Your KYC is expired. Your account will be blocked in 24 hours. Update now: http://icici-kyc-update.in/verify"',
        answer: QuizAnswer.phishing,
        explanation:
        'This is a phishing SMS. Real ICICI Bank SMS links end in ".icicibank.com". The link "icici-kyc-update.in" is a fake website designed to steal your login details. Banks send KYC notices by post or through their official app — not suspicious SMS links.',
        redFlags: [
          '"Blocked in 24 hours" — creating panic',
          'The link domain is not ".icicibank.com"',
          'KYC updates are done through the official bank app or branch',
          'Unregistered domain ".in" with hyphen words is a red flag',
        ],
      ),
      QuizQuestion(
        senderLabel: 'SMS from AD-PAYTMB',
        scenario:
        '"Paytm: ₹200 cashback credited to your Paytm wallet for completing 5 transactions this month. Check your wallet balance in the Paytm app."',
        answer: QuizAnswer.safe,
        explanation:
        'This is a genuine Paytm cashback notification. It is not asking you to click a link or share any details — just informing you of a reward. The sender "AD-PAYTMB" is a registered sender ID. You can safely open the Paytm app directly to verify.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'WhatsApp from unknown: +1-234-XXXXXXX',
        scenario:
        '"TRAI (Telecom Regulatory Authority): Your mobile number will be disconnected in 2 hours due to illegal activity. Call our officer immediately: 09XXXXXXXX"',
        answer: QuizAnswer.phishing,
        explanation:
        'TRAI does not contact people via WhatsApp from foreign numbers (+1 is a US number). TRAI does not disconnect phones — your telecom operator does. This is a classic impersonation scam. Do not call the number given.',
        redFlags: [
          'TRAI does not use WhatsApp for official communication',
          '+1 is a US/Canada number — not an Indian government number',
          '"2 hours" urgency is designed to cause panic',
          'Calling the given number connects you to the scammer',
        ],
      ),
      QuizQuestion(
        senderLabel: 'SMS from AM-AMAZON',
        scenario:
        '"Amazon: Your order #402-XXXXXXX for Blue Shirt has been shipped. Expected delivery: 12-Apr. Track at amazon.in/track"',
        answer: QuizAnswer.safe,
        explanation:
        'This is a genuine Amazon shipping notification. It contains a real order number, a real delivery date, and directs you to amazon.in — the official Amazon India website. No personal information is being asked for.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Email from noreply@uidai-update.org',
        scenario:
        '"Dear Citizen, Your Aadhaar card is expiring. To renew it, click here and pay ₹299: http://aadhaar-renew.org/pay"',
        answer: QuizAnswer.phishing,
        explanation:
        'Aadhaar cards do NOT expire — they are valid for life. "uidai-update.org" is not the official UIDAI website (uidai.gov.in). This is a phishing email designed to steal ₹299 and your Aadhaar details. UIDAI never charges for Aadhaar services.',
        redFlags: [
          'Aadhaar cards never expire — this premise is false',
          'Official UIDAI website is uidai.gov.in — not ".org"',
          'UIDAI does not charge fees for Aadhaar services',
          'Asking for payment via a link is a major red flag',
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
    title: 'Fake Websites',
    subtitle: 'Don\'t get fooled online',
    description: 'Learn how to tell real websites from fraudulent copies.',
    animationKey: AnimationTopic.fakeWebsite, // ← fake website animation
    lessonPages: [
      LessonPage(
        emoji: '🌐',
        heading: 'Real vs. Fake Websites',
        body:
        'Fraudsters build websites that look exactly like real banks, government portals, and shopping sites.\n\nThey copy the logo, colors, and layout. Only the web address (URL) is different — and most people never notice.',
        tip: '👀 Always check the web address before entering your details.',
      ),
      LessonPage(
        emoji: '🔒',
        heading: 'How to Check a Website',
        body:
        'Steps to verify a website:\n\n1️⃣ Look for 🔒 in the browser — means the connection is secure\n2️⃣ Check the domain: sbi.co.in ✅ or sbi-login.net ❌\n3️⃣ Government sites end in .gov.in\n4️⃣ Never trust sites with extra words like "secure", "verify", "update" in the URL\n5️⃣ When in doubt — type the address yourself, don\'t click links',
        tip: '💡 Bookmark the websites you use most — then you never need to search.',
      ),
      LessonPage(
        emoji: '🔎',
        heading: 'Google Search Traps',
        body:
        'When you search "SBI Bank login" on Google, the first result might be an AD — a paid advertisement from a scammer!\n\nAlways:\n\n✅ Skip the "Ad" results at the top\n✅ Scroll down to the real website\n✅ Or type the address directly: onlinesbi.sbi\n\nScammers pay for ads to appear above the real website.',
        tip: '🚨 Sponsored/Ad results in Google are NOT always safe — scammers use them.',
      ),
    ],
    questions: [
      QuizQuestion(
        senderLabel: 'Google search result — first result (Ad)',
        scenario:
        'You search "PAN card apply online". The first result is an Ad: "Apply PAN Card — pancard-india.org — Fast service, ₹499 only"',
        answer: QuizAnswer.phishing,
        explanation:
        'The official PAN card website is onlineservices.nsdl.com or tin.tin.nsdl.com. "pancard-india.org" is a fake website. Also, applying for PAN through the official NSDL website costs much less (₹107 for Indian address). Ads in Google can be purchased by anyone — including scammers.',
        redFlags: [
          'Not an official government domain (.gov.in or nsdl.com)',
          'Ads in search results can be bought by scammers',
          'Price (₹499) is higher than the real fee (₹107)',
          'Always go to the official site — not an ad link',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Website URL in browser',
        scenario:
        'You want to check your EPFO (PF) balance. You type "epfo" in Google and click the first result. The browser shows: https://www.epfindia.gov.in',
        answer: QuizAnswer.safe,
        explanation:
        'This is the official EPFO website. The domain ".gov.in" confirms it is a Government of India website. The "https://" and padlock indicate a secure connection. This is safe to use.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Link in SMS',
        scenario:
        '"Your IRCTC ticket is confirmed! Download your e-ticket here: irctc-ticket-download.com/ticket/PNR1234"',
        answer: QuizAnswer.phishing,
        explanation:
        'IRCTC e-tickets are sent from the official IRCTC website (irctc.co.in) or the IRCTC Rail Connect app. "irctc-ticket-download.com" is not an official IRCTC domain. Clicking this could install malware on your phone. Download tickets only from irctc.co.in or the official app.',
        redFlags: [
          'Official IRCTC domain is irctc.co.in — not a .com with extra words',
          'IRCTC sends tickets directly to email — no need to "download" from a link',
          'Fake ticket sites can steal your login credentials',
        ],
      ),
      QuizQuestion(
        senderLabel: 'Website URL in browser',
        scenario:
        'You are shopping online. The website URL shows: https://www.flipkart.com/shoes/running — and you see a 🔒 padlock in the browser bar.',
        answer: QuizAnswer.safe,
        explanation:
        'This is the genuine Flipkart website. The domain "flipkart.com" is correct, "https://" means it is secure, and the padlock confirms the secure connection. This is safe to browse and shop.',
        redFlags: [],
      ),
      QuizQuestion(
        senderLabel: 'Link received on WhatsApp',
        scenario:
        '"Get your DigiLocker Aadhaar card — easy download! Click: digilocker-aadhaar.in/download"',
        answer: QuizAnswer.phishing,
        explanation:
        'DigiLocker\'s official website is digilocker.gov.in — a Government of India portal. "digilocker-aadhaar.in" is a fake website. Downloading your Aadhaar from a fake site could expose your Aadhaar number and biometrics to fraudsters.',
        redFlags: [
          'Official DigiLocker URL is digilocker.gov.in',
          '".in" domain with extra words is suspicious',
          'Aadhaar download links shared on WhatsApp are a major red flag',
          'Could steal your Aadhaar number and personal data',
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
        emoji: '🤖',
        heading: 'AI Can Fake Faces & Voices',
        body:
        'Artificial Intelligence can now:\n\n🎬 Create fake videos of real people saying things they never said\n🔊 Clone someone\'s voice from just 10 seconds of audio\n📸 Generate realistic fake photos of people\n\nThese are called "deepfakes" and they are being used for scams.',
        tip: '⚠️ If a video or call seems unusual — verify before you act.',
      ),
      LessonPage(
        emoji: '📹',
        heading: 'How to Spot a Deepfake Video',
        body:
        'Signs a video might be a deepfake:\n\n❌ The face looks slightly blurry or "melting" at edges\n❌ Eyes don\'t blink naturally\n❌ Lip movement doesn\'t match the words\n❌ Lighting on the face doesn\'t match the background\n❌ The person says things they would never say\n\nWhen in doubt — do not believe, share, or act on such videos.',
        tip: '✅ Verify shocking videos on fact-check sites like boomlive.in or altnews.in',
      ),
      LessonPage(
        emoji: '📞',
        heading: 'Voice Cloning Scams',
        body:
        'A scammer can clone your son\'s or daughter\'s voice and call you saying:\n\n"Maa/Papa, I am in an accident. I need ₹50,000 immediately. Don\'t call me back — I\'ll explain later."\n\nThe voice sounds exactly like your child. But it is AI.\n\nAlways hang up and call back on their real number.',
        tip: '📵 Create a family "safe word" — a secret word only your family knows, to verify real emergencies.',
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
        senderLabel: 'Unexpected phone call — voice sounds like your son',
        scenario:
        '"Papa, it\'s me. I had a small accident. My phone is broken, I\'m calling from a friend\'s number. I need ₹30,000 right now for hospital. Please send on this UPI: scammer@upi. Don\'t call Maa — she will worry."',
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
      QuizQuestion(
        senderLabel: 'Video call — WhatsApp, unknown number',
        scenario:
        'A video call comes from an unknown number. The video shows a police officer in uniform saying you have been named in a drug trafficking case and must pay ₹1 lakh immediately to avoid arrest.',
        answer: QuizAnswer.phishing,
        explanation:
        'This is a "digital arrest" scam using deepfake or real actors in police uniforms. Police do not arrest people over video calls. They do not accept payments on WhatsApp. This is 100% fraud. Hang up and report on cybercrime.gov.in.',
        redFlags: [
          'Police do not arrest or fine people over WhatsApp video calls',
          'Officers in uniform on video calls can be fake — even AI-generated',
          'Demand for immediate payment to avoid arrest is pure fraud',
          'Report on cybercrime.gov.in — do not pay',
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
    animationKey: AnimationTopic.deepfake, // ← deepfake animation (master level)
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
        'This is a very common scam — the friend\'s Facebook account was hacked. The hacker is messaging all their contacts asking for money. "Don\'t tell anyone" is designed to stop you from verifying. Always call your friend on their real phone number before sending any money.',
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
