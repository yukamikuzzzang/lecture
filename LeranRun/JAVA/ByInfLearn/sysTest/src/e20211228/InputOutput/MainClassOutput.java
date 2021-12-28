package e20211228.InputOutput;

import java.io.*;

public class MainClassOutput {
    public static void main(String[] args) {

        //write()
        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(".\\src\\e20211228\\InputOutput\\text\\HelloW.txt");
            String data = "Hello Java World!!";
            byte[] arr = data.getBytes();

            try {
                outputStream.write(arr);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (outputStream != null) outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        /*
         FileOutputStream에서 폴더명으로 넘기게 되면 파일이 아니라서 엑세스 거부 Exception을 띄우게 된다.
         https://bit.ly/3z5oeyT 참고
         */

        //write()
        OutputStream outputStream1 = null;
        try {
            outputStream1 = new FileOutputStream(".\\src\\e20211228\\InputOutput\\text\\HelloM.txt");
            String data = "Hello Java World!";
            byte[] arr = data.getBytes();   //배열을 넣어주는 친구.

            try {
                outputStream1.write(arr, 0, 7); //0번째부터 4번째까지, 5글자 (공백도 문자)
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (outputStream1 != null) outputStream1.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
