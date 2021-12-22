package e20211222;

import java.util.Arrays;

/*8강*/
public class ArrayAddress {
    public static void main(String[] args){
        //배열의 기본 속성
        int[] arrAtt1 = {10, 20, 30, 40, 50, 60};
        int[] arrAtt2 = null;
        int[] arrAtt3 = null;

        //배열 길이
        System.out.println("arrAtt1.length : " + arrAtt1.length);

        //배열 요소 출력
        System.out.println("arrAtt1 : " + Arrays.toString(arrAtt1));

        //배열 요소 복사
        arrAtt3 = Arrays.copyOf(arrAtt1, arrAtt1.length);
        System.out.println("arrAtt3 : " + Arrays.toString(arrAtt3));

        //배열 레퍼런스
        arrAtt2 = arrAtt1;
        System.out.println("arrAtt2 : " + Arrays.toString(arrAtt2));

        System.out.println("arrAtt1 : "+arrAtt1);
        System.out.println("arrAtt2 : "+arrAtt2);
        System.out.println("arrAtt3 : "+arrAtt3);

        //다차원 배열
        int[][] arrMul = new int[3][2];
        arrMul[0][0] = 10;
        arrMul[0][1] = 100;
        arrMul[1][0] = 20;
        arrMul[1][1] = 200;
        arrMul[2][0] = 30;
        arrMul[2][1] = 300;

        System.out.println("arrMul[0] : " + Arrays.toString(arrMul[0]));
        System.out.println("arrMul[1] : " + Arrays.toString(arrMul[1]));
        System.out.println("arrMul[2] : " + Arrays.toString(arrMul[2]));

    }
}
