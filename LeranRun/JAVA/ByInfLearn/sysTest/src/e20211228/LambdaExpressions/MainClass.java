package e20211228.LambdaExpressions;
/*19강*/
public class MainClass {
    public static void main(String[] args){
        //곧바로 구현해서 실행문을 만들고, anonymous클래스 실행시키듯이 실행시키면..!
        //매개변수와 실행문만으로 작성(접근자, 반환형, return 키워드 생략)
        LamdaInterface1 li1 =  (String s1, String s2, String s3) -> { System.out.println(s1 + " " + s2 + " " + s3);};
        li1.method("Hello","Java","World");

        //매개변수가 1개이거나 타입이 같을 때, 타입을 생략할 수 있음.
        LamdaInterface2 li2 = (s1) -> {System.out.println(s1);};
        li2.method("Hello");

        //실행문이 1개 일 때 '{ }'를 생략할 수 있음.
        LamdaInterface2 li3 = (s1) -> System.out.println(s1);
        li3.method("Java");

        //매개변수와 실행문이 1개 일 때, '()','{}'를 생략할 수 있다.
        LamdaInterface2 li4 = s1 -> System.out.println(s1);
        li4.method("World");

        //매개변수가 없을 때, '()'만 작성
        LamdaInterface3 li5 = () -> System.out.println("no parameter");
        li5.method();
        
        //반환값이 있는 경우
        LamdaInterface4 li6 = (x, y) -> {
            int result = x + y;
            return result;
        };
        System.out.printf("li6.method(10,20) : %d\n", li6.method(10,20));

        li6 = (x, y) -> {
          int result = x * y;
          return result;
        };
        System.out.printf("li6.method(10,20) : %d\n", li6.method(10,20));

        li6 = (x, y) -> {
            int result = x - y;
            return result;
        };
        System.out.printf("li6.method(10,20) : %d\n", li6.method(10,20));
    }
}
