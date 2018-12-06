package top.beibei.beans;/**
 * @Author: Zbeibei
 * @Date: Created in 2018/11/16 20:50
 * @Descrption:
 */

import java.util.HashMap;
import java.util.Map;

/**
 * @Author: lenovo
 * @Date: 2018/11/16 20:50
 * @Desc:
 */

/**
 * 通过此方法获取返回的状态信息以及将数据进行集成，
 * 将页面数据添加进该类中
 */

public class Msg {

//    状态码
    private int code;
//    状态信息
    private String msg;

//    返回给浏览器的信息
    private Map<String,Object> extend =new HashMap<String,Object>();

    public static Msg success(){
        Msg result =new Msg();
        result.setCode(100);
        result.setMsg("操作成功");
        return result;
    }

    public static Msg fail(){
        Msg result =new Msg();
        result.setCode(200);
        result.setMsg("操作失败");
        return result;

    }

    public  Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
