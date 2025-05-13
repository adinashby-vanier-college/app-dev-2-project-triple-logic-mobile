import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import android.util.Base64;

public class KeyHashGenerator {
    public static void main(String[] args) {
        try {
            PackageInfo info = getPackageManager().getPackageInfo(
                    "com.example.group_project",
                    PackageManager.GET_SIGNATURES);
            for (Signature signature : info.signatures) {
                MessageDigest md = MessageDigest.getInstance("SHA");
                md.update(signature.toByteArray());
                String keyHash = Base64.encodeToString(md.digest(), Base64.DEFAULT);
                System.out.println("KeyHash: " + keyHash);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 