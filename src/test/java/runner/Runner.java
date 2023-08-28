package runner;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

import io.qameta.allure.karate.AllureKarate;

public class Runner {

    @Test
    Karate testAll() {
        return Karate
            .run("classpath:features")
            .relativeTo(getClass())
            .hook(new AllureKarate())
            .outputJunitXml(true)
            .outputCucumberJson(true);
    }

    @org.junit.jupiter.api.Test
    void testAllParallel() {
        Results results = com.intuit.karate.Runner
            .path("classpath:features")
            .relativeTo(getClass())
            .hook(new AllureKarate())
            .outputJunitXml(true)
            .outputCucumberJson(true)
            .parallel(5);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
    @Test
    Karate testWithTag() {
        return Karate
            .run("classpath:features")
            .tags("@SchemaValidation")
            .relativeTo(getClass())
            .hook(new AllureKarate())
            .outputJunitXml(true)
            .outputCucumberJson(true);
    }
    
    @Test
    Karate testWithMultipleTag() {
        return Karate
            .run("classpath:features")
            .tags("@Get", "@SchemaValidation")
            .relativeTo(getClass())
            .hook(new AllureKarate())
            .outputJunitXml(true)
            .outputCucumberJson(true);
    }
    
    @Test
    Karate testPost() {
        return Karate
            .run("classpath:features")
            .tags("@Post")
            .relativeTo(getClass())
            .hook(new AllureKarate())
            .outputJunitXml(true)
            .outputCucumberJson(true);
    }
}
