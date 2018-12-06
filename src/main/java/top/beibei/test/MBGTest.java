package top.beibei.test;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/13 16:18
 * @Descrption:
 */

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import sun.applet.Main;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: lenovo
 * @Date: 2018/11/13 16:18
 * @Desc:
 */

/**
 * 生成dao\mappper等文件
 */
public class MBGTest {
    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
        myBatisGenerator.generate(null);
    }
}
