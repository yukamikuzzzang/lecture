package e20211228.InputOutput;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

public class MainClassInput {
    public static void main(String[] args) {

        //read()
        InputStream inputStream = null;
        try {
            inputStream = new FileInputStream(".\\src\\e20211228\\InputOutput\\text\\hello.txt");
            //inputStream = new FileInputStream(".\\src\\e20211228\\InputOutput\\text\\helloSample.txt");

            int data = 0;

            while (true) {
                try {
                    data = inputStream.read();
                } catch (IOException e) {
                    e.printStackTrace();
                }

                if (data == -1) break; //data == -1, 읽을 데이터가 없다.
                System.out.println("data : " + data);
                //1바이트씩 읽는다. hello.txt파일에 있는 내용에 대한 ASCII코드이다.
                //System.out.println(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(inputStream != null) inputStream.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }

        //read(byte[])
        InputStream inputBytes = null;
        try{
            inputBytes = new FileInputStream(".\\src\\e20211228\\InputOutput\\text\\hello.txt");
            //inputBytes = new FileInputStream(".\\src\\e20211228\\InputOutput\\text\\helloSample.txt");

            int data1 = 0;
            byte[] bs = new byte[3];    //3바이트씩 묶어서 읽어줌.

            while(true){
                try{
                    data1 = inputBytes.read(bs);
                } catch (IOException e){
                    e.printStackTrace();
                }
                if(data1 == -1) break;
                System.out.println("data : "+data1);
                for(int i = 0; i < bs.length;i++){
                    System.out.println("bs["+i+"] : "+bs[i]);
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                if(inputBytes != null) inputBytes.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }

        /*
        데이터가 하나 있는데 세 개나 나오는 이유?
        예전에 기록했던 값이 아직 남아있었기 때문.
        2,3번은 쓰레기값.
        data : 1
        bs[0] : 63
        bs[1] : 111
        bs[2] : 117
         */

    }
}
