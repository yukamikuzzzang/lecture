package e20211228.Networking;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Scanner;

public class MainClassClient {
    public static void main(String[] args) {
        Socket socket = null;

        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;

        InputStream inputStream = null;
        DataInputStream dataInputStream = null;

        Scanner scanner = null;

        //네트워크라 예외처리
        try {
            socket = new Socket("localhost", 9000); //127.0.0.1 = localhost
            System.out.println("서버 연결 완료~~");
            inputStream = socket.getInputStream();
            dataInputStream = new DataInputStream(inputStream);
            //문자 단위로 처리하기 위한 dataInputStream
            outputStream = socket.getOutputStream();
            dataOutputStream = new DataOutputStream(outputStream);
            //소켓 객체에 대해 알면 통신하는데엔 문제가 없다.

            scanner = new Scanner(System.in);

            while (true) {
                System.out.println("메시지 입력~");
                String outMessage = scanner.nextLine();
                dataOutputStream.writeUTF(outMessage);
                //사용자가 입력한 데이터를 서버로 보내기 위한 String
                dataOutputStream.flush(); //완벽히 비워주기
                //→

                //←
                String inMessage = dataInputStream.readUTF();
                //server에서 준 걸 받아 읽음.
                System.out.println("inMessage : " + inMessage);

                if (outMessage.equals("STOP")) break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (socket != null) socket.close();
                if (inputStream != null) inputStream.close();
                if (dataInputStream != null) dataInputStream.close();
                if (outputStream != null) outputStream.close();
                if (dataOutputStream != null) dataOutputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
    /*예외처리 제외하면 딱 두 줄*/
    /*서버를 먼저 구동시키고 클라이언트를 실행시키자.*/
}
