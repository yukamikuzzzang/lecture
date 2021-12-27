package e20211227.abstractClass;

import java.awt.*;

public abstract class AbstractClassEx {
    int num;
    String str;

    public AbstractClassEx(){
        System.out.println("AbstractClassEx Constructor");
    }
    public AbstractClassEx(int i, String s){
        System.out.println("AbstractClassEx Constructor");

        this.num = i;
        this.str = s;
    }

    public void fun1() {
        System.out.println("-- fun1() START --");
    }

    public abstract void fun2();



}
