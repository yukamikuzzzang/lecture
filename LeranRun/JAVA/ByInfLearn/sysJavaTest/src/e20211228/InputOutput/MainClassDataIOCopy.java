package e20211228.InputOutput;

import java.io.*;

public class MainClassDataIOCopy {
    public static void main(String[] args) {

        InputStream inputStream = null;
        DataInputStream dataInputStream = null;
        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;

        try {
            inputStream = new FileInputStream(".\\src\\e20211228\\InputOutput\\text\\helloWorld.txt");
            dataInputStream = new DataInputStream(inputStream);
            /*
                dataIntputStream을 하기 위해서는 (data)OutputStream을 통해서 만든 파일'만' 입력으로서 사용할 수 있다.
                //helloWorld.txt 파일 참고
             */
            String str = dataInputStream.readUTF();

            outputStream = new FileOutputStream(".\\src\\e20211228\\InputOutput\\text\\helloDataCopy.txt");
            dataOutputStream = new DataOutputStream(outputStream);

            dataOutputStream.writeUTF(str);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (dataOutputStream != null) dataOutputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                if (dataInputStream != null) dataInputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (inputStream != null) inputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            try {
                if (outputStream != null) outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (outputStream != null) outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }


        }
    }
}
