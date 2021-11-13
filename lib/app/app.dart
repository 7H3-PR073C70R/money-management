import '../service/db_service.dart';
import '../service/shared_prefs.dart';
import '../service/user_service.dart';
import '../ui/views/auth/confirm_email/confirm_email_view.dart';
import '../ui/views/auth/email_verification/email_verification_view.dart';
import '../ui/views/auth/forget_password/forget_password_view.dart';
import '../ui/views/auth/login/login_view.dart';
import '../ui/views/auth/login_or_signup/login_or_signup_view.dart';
import '../ui/views/auth/sign_up/signup_view.dart';
import '../ui/views/auth/start_up/start_up_view.dart';
import '../ui/views/auth/verified/verified_view.dart';
import '../ui/views/main/budget/budget_info/add_expenses.dart';
import '../ui/views/main/budget/budget_info/budget_info_view.dart';
import '../ui/views/main/budget/budget_view.dart';
import '../ui/views/main/budget/create_budget_view.dart';
import '../ui/views/main/change_currency/change_currency_view.dart';
import '../ui/views/main/income_and_expenses/add_income_or_expenses_view.dart';
import '../ui/views/main/main_view.dart';
import '../ui/views/main/notes/add_note_view.dart';
import '../ui/views/main/notes/note_view.dart';
import '../ui/views/main/notes/read_note.dart';
import '../ui/views/profile_setting/profile_setting_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: StartUpView),
    CupertinoRoute(page: LoginView),
    CupertinoRoute(page: SignUpView),
    CupertinoRoute(page: LoginOrSignUpView),
    CupertinoRoute(page: EmailVarificationView),
    CupertinoRoute(page: ConfirmEmailView),
    CupertinoRoute(page: VerifiedView),
    CupertinoRoute(page: ForgetPasswordView),
    CupertinoRoute(page: MainView),
    CupertinoRoute(page: ProfileSettingsView),
    CupertinoRoute(page: AddNoteView),    
    CupertinoRoute(page: NoteView),    
    CupertinoRoute(page: AddIncomeOrExpensesView),
    CupertinoRoute(page: ChangeCurrencyView),
    CupertinoRoute(page: BudgetView),
    CupertinoRoute(page: CreateBudgetView),
    CupertinoRoute(page: ReadNoteView),
    CupertinoRoute(page: BudgetInfoView),
    CupertinoRoute(page: AddBudgetExpensesView),
  ],
  dependencies: [
    Presolve(
      classType: DataBaseService,
      presolveUsing: DataBaseService.getInstance,
    ),
    Presolve(
      classType: SharedPresService,
      presolveUsing: SharedPresService.getInstance,
    ),
    LazySingleton(classType: UserService)
  ],
  logger: StackedLogger()
)

class AppSetup{}