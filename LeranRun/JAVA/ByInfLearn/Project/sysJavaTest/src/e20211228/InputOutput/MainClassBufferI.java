package e20211228.InputOutput;

import java.io.*;

public class MainClassBufferI {
    public static void main(String[] args) {
        String fileName = ".\\src\\e20211228\\InputOutput\\text\\";

        //Buffered Read
        BufferedReader br = null;
        FileReader fr = null;   //InputStreamReader의 자식

        try {
            fr = new FileReader(fileName + "hello.txt");
            br = new BufferedReader(fr); //FileReader ...> BufferedReader

            String strLine;

            while ((strLine = br.readLine()) != null) { //하나의 라인씩 읽어오기
                System.out.println(strLine);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fr != null) fr.close();
                if (br != null) br.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }
}
