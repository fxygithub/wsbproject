package com.hn.sanya.bov.util.mongodbUtil;

public enum OAuth2Client {

    USER("wsb"),PASSWORD("m4G6zFOJQTsKlB6UrLP1");//这里需要修改成自己注册的应用

    private String value;

    OAuth2Client(String value){
        this.value = value;
    }

    public String getValue() {
        return value;
    }

}
