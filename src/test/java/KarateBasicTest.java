import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate testAllFeatures() {
        return Karate.run(
            "classpath:get-characters.feature",
            "classpath:post-characters.feature",
            "classpath:put-characters.feature",
            "classpath:delete-characters.feature"
        );
    }
}
