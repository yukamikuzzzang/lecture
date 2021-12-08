package e20211208;

public class SecondClass {
    public static void main(String[] args){
       //자동(묵시)적 형변환
       byte by = 10;
       int in = by;
       System.out.println("in = "+ in);

       //명시적 변환
        int iVar = 123456;
        byte bVar = (byte)iVar;
        System.out.println("bVar = " + bVar);

    }
}
