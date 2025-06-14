import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const String privacyPolicyText = """
أ- مقدمة

نحن في مجلس الشعب السوري نولي أهمية كبيرة لحماية خصوصيتك وحماية بياناتك الشخصية. توضح هذه السياسة كيفية جمع المعلومات واستخدامها وحمايتها أثناء استخدامك لتطبيقنا.

ب- جمع المعلومات

نقوم بجمع المعلومات التي تقدمها لنا طوعاً عند استخدامك للتطبيق، مثل الاسم، البريد الإلكتروني، وأي بيانات أخرى تقوم بمشاركتها معنا. كما قد نقوم بجمع معلومات تلقائية مثل نوع الجهاز، نظام التشغيل، وعنوان الـ IP لتحسين تجربتك.

ج- استخدام المعلومات

تُستخدم المعلومات التي نجمعها لتحسين خدماتنا، التواصل معك بشأن التحديثات أو الإشعارات المهمة، وضمان أمان حسابك. لا نشارك معلوماتك مع جهات خارجية إلا بموافقتك أو عندما يتطلب القانون ذلك.

د- ملفات تعريف الارتباط (Cookies)

يستخدم تطبيقنا ملفات تعريف الارتباط لتحسين الأداء وتخصيص المحتوى وفقًا لتفضيلاتك. يمكنك تعطيل ملفات تعريف الارتباط من إعدادات جهازك، لكن قد يؤثر ذلك على بعض وظائف التطبيق.

هـ- حماية البيانات

نلتزم باتخاذ كافة الإجراءات التقنية والتنظيمية لحماية بياناتك من الوصول غير المصرح به أو التغيير أو الكشف أو الحذف.

و- حقوقك

لك الحق في الوصول إلى بياناتك الشخصية، طلب تصحيحها، أو حذفها في أي وقت. كما يمكنك الاعتراض على معالجة بياناتك أو طلب تقييدها وفقًا للقوانين المعمول بها.

ز- التغييرات على سياسة الخصوصية

قد نقوم بتحديث هذه السياسة بين الحين والآخر. سنخطرك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.

ح- التواصل معنا

إذا كانت لديك أي أسئلة أو استفسارات بخصوص سياسة الخصوصية هذه، يرجى التواصل معنا عبر القنوات الرسمية لمجلس الشعب السوري.

شكراً لاستخدامك تطبيقنا وثقتك بنا.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("السياسة والخصوصية"),
      ),
      body: Padding(
        padding:
        const EdgeInsets.only(top: 24.0, left: 8, right: 8, bottom: 12),
        child: Column(
          children: [
            // Header Section
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Image.asset("assets/syria-logo-png_seeklogo-613100 1.png"),
                  const SizedBox(height: 5),
                  const Text(
                    "مجلس الشعب السوري",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Syrian People's Assembly",
                    style: TextStyle(
                        color: Color(0xff2E8F5A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Policy Title
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                ":السياسة والخصوصية",
                style: TextStyle(
                    color: Color(0xff2E8F5A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Scrollable Policy Text
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    privacyPolicyText,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
