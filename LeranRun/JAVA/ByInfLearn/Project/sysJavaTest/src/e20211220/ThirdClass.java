package e20211220;

/*6장*/
public class ThirdClass {
    public static void main(String[] args){
        int x = 10;
        int y = 20;

        //대입 연산자
        System.out.println("x = "+ x);
        System.out.println("y = "+ y);

        x = y;
        System.out.println("x = "+ x);
        System.out.println("y = "+ y);

        //산술연산자
        x = 10;
        //y = 20;

        System.out.println("x + y = " + ( x + y ));
        System.out.println("x - y = " + ( x - y ));
        System.out.println("x * y = " + ( x * y ));
        System.out.println("x / y = " + ( x / y ));
        //x와 y 모두 int형이기에 소수점 자리가 나오지 않음.
        System.out.println("x % y = " + ( x % y ));

        //명시적 형변환 적용
        System.out.println("(double)x / y = " + ((double)x / y));

        //복합 대입연산자
        //x = 10;
        /*
            x = x + 10;
            x += 10;
         */
        System.out.println("x += 10 : "+(x += 10));
        x = 10;
        System.out.println("x -= 10 : "+(x -= 10));
        x = 10;
        System.out.println("x *= 10 : "+(x *= 10));
        x = 10;
        System.out.println("x /= 10 : "+(x /= 10));
        x = 10;
        System.out.println("x %= 10 : "+(x %= 10));

        //관계 연산자
        x = 10;
        y = 20;
        System.out.println("x > y : " + (x > y));
        System.out.println("x < y : " + (x < y));
        System.out.println("x >= y : " + (x >= y));
        System.out.println("x <= y : " + (x <= y));
        System.out.println("x == y : " + (x == y));
        System.out.println("x != y : " + (x != y));

        //증감 연산자
        //x = 10;
        System.out.println("++x : " + (++x)); // x = x + 1
        x = 10;
        System.out.println("x++ : " + (x++));
        System.out.println(x);
        x = 10;
        System.out.println("--x : " + (--x));
        x = 10;
        System.out.println("x-- : " + (x--));
        System.out.println(x);

        //논리 연산자
        boolean b1 = false;
        boolean b2 = true;
        System.out.println("b1 && b2 : " + (b1 && b2));
        System.out.println("b1 || b2 : " + (b1 || b2));
        System.out.println("!b1 : " + !b1);
        System.out.println("!b2 : " + !b2);

        //조건(삼항) 연산자
        x = 10; y = 20;
        int result = 0;
        result = (x > y) ? 100 : 200;
        System.out.println("result : " + result);

        result = (x < y) ? 100 : 200;
        System.out.println("result : " + result);

        result = (x == y) ? 100 : 200;
        System.out.println("result : " + result);

        //비트 연산자
        x = 2; //... 0010
        y = 3; //... 0011
        //_______________
        //AND     .. 0010 = 2
        //OR      .. 0011 = 3
        //XOR     .. 0001 = 1
        System.out.println("x & y : " + (x & y));
        System.out.println("x | y : " + (x | y));
        System.out.println("x ^ y : " + (x ^ y));
    }
}
