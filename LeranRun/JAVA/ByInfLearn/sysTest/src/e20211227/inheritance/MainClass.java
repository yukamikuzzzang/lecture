package e20211227.inheritance;

import java.util.ArrayList;

/*18강*/
public class MainClass {
    public static void main(String[] args){
        ChildClass childClass = new ChildClass();

        childClass.childFun();
        childClass.parentFun();

        //childClass.privateFun(); private 접근불가. 상속에선 제외.

        /*19강*/
        childClass.makeJJajang();

        FirstChildClass ch = new FirstChildClass();
        //ch의 데이터타입? ChildClass

        ParentClass[] pArr = new ParentClass[2];

        FirstChildClass fch = new FirstChildClass();
        //ParentClass fch = new FirstChildClass();
        //상위 클래스의 타입이어도 상관없음

        SecondChildClass sch = new SecondChildClass();
        //ParentClass sch = new SecondChildClass();
        //FirstChild Class, SencondChild Class 모두 다른 객체이나 데이터 타입을 통일할 수 있음(상속)
        pArr[0] = fch;
        pArr[1] = sch;

        ArrayList arrayList = new ArrayList();

        childClass.getOpenYear();

    }
}
