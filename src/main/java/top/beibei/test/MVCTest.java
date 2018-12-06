package top.beibei.test;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/15 21:13
 * @Descrption:
 */

/**
 * @Author: lenovo
 * @Date: 2018/11/15 21:13
 * @Desc:
 */

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import top.beibei.beans.Employee;

import java.util.List;

/***
 * 使用spring测试模块提供的测试请求功能
 * spring4测试的时候，需要servlet3.0
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring/applicationContext-dao.xml", "classpath:springmvc/dispatcher-servlet.xml"})
public class MVCTest {



//    虚拟mvc请求，获取处理结果
    MockMvc mockMvc;
//    传入springmvc的ioc
    @Autowired
    private WebApplicationContext context;

//    之前引入
    @Before
    public void initMokcMvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();

    }

    @Test
    public void testPage(){

        try {
//            模拟请求拿到返回值
            MvcResult result= mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();
//        请求成功后，请求中有pageInfo，取出pageInfo进行验证
            MockHttpServletRequest request=result.getRequest();
            PageInfo pi= (PageInfo) request.getAttribute("pageInfo");
            System.out.println("当前页码:"+pi.getPageNum());
            System.out.println("总页码："+pi.getPages());
            System.out.println("总记录数："+pi.getTotal());
            System.out.println("总页连续显示的页码");
            int[] nums=pi.getNavigatepageNums();

            for(int i:nums){
                System.out.println(""+i);

            }

//            获取员工数据
            List<Employee> list= pi.getList();
            for(Employee employee:list){

                System.out.println("ID"+employee.getEmpId());
                System.out.println("姓名"+employee.getEmpName());
            }


        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
