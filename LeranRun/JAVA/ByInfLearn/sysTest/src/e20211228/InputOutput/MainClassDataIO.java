package e20211228.InputOutput;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class MainClassDataIO {
    public static void main(String[] args) {
        //바이트 단위를 개선(아스키코드값으로 보여줬던 것..)...> 문자/문자열 단위로 처리

        //outputStream
        String str = "Hello Java World!";
        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;

        try {
            outputStream = new FileOutputStream("src\\e20211228\\InputOutput\\text\\helloWorld.txt");
            dataOutputStream = new DataOutputStream(outputStream);  
            //outputStream을 dataOutputStream의 생성자로 삼음
            //outputStream을 확장
            dataOutputStream.writeUTF(str); //UTF-8로 쓰기

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (dataOutputStream != null) dataOutputStream.close();
            } catch (Exception e){
                e.printStackTrace();
            }

            try{
                if(outputStream != null) outputStream.close();
            } catch (Exception e){
                e.printStackTrace();
            }
        }
    }
}
