package e20211228.InputOutput;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class MainClassBufferO {
    public static void main(String[] args) {
        //Buffered Write
        String fileName = ".\\src\\e20211228\\InputOutput\\text\\helloB.txt";
        BufferedWriter bf = null;
        FileWriter fw = null;

        String str = "Hello Java World~~\n";
        str += "Hello C World~~\n";
        str += "Hello C++ World~~!\n";

        try {
            fw = new FileWriter(fileName);
            bf = new BufferedWriter(fw);

            bf.write(str);

        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            try {
                if (bf != null) bf.close();
                if (fw != null) fw.close();
                /*
                    .close()할 때에는 BufferedWriter가 FileWriter보다 먼저 .close() 되어야한다.
                    안그러면 파일이 쓰여지지 않는다..
                    또한 .close()를 이행하지 않으면 텍스트가 남지 않는다..
                    버퍼만 그런 것 같다..
                    문자열을 다루는 거라서 그런가?
                 */
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }
}
