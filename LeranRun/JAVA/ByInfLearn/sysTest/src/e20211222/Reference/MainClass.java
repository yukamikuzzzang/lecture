package e20211222.Reference;
/*14강*/
public class MainClass {
    public static void main(String[] args){
        ObjectClass obj1 = new ObjectClass();
        ObjectClass obj2 = new ObjectClass();
        ObjectClass obj3 = new ObjectClass();

        System.out.println("obj1 : "+ obj1);
        System.out.println("obj2 : "+ obj2);
        System.out.println("obj3 : "+ obj3);
        /*
            obj1 : e20211222.Reference.ObjectClass@6d311334
            obj2 : e20211222.Reference.ObjectClass@682a0b20
            obj3 : e20211222.Reference.ObjectClass@3d075dc0
            다 다른 메모리 공간에 생성.
         */

        obj1.getInfo();
        obj1 = null;     //레퍼런스가 끊김. GC가 회수해감.
        //obj1.getInfo();  //NullPointException

        obj2.getInfo();  //예외 발생 시 이후 코드는 실행되지 않음

    }
}
