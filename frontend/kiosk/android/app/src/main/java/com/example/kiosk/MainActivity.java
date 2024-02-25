package "com.example.kiosk"

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.thinkabout.nativenaver/android";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if(call.method.equals("imageDownload"))
                        }
                );
    }
}