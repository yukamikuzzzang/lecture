package e20211228.Networking.bidrectional;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

public class MainClassServer {
    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        Socket socket = null;

        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;

        InputStream inputStream = null;
        DataInputStream dataInputStream = null;

        try {
            serverSocket = new ServerSocket(9000);   //서버 소켓 생성 완료!
            System.out.println("클라이언트 맞을 준비 완료!");

            socket = serverSocket.accept(); //socket 객체를 반환 with .accept()
            //client의 dataOutputStream.writeUTF()의 반응
            System.out.println("클라이언트 연결");
            System.out.println("socket : " + socket);

           inputStream = socket.getInputStream();
           dataInputStream = new DataInputStream(inputStream);

           outputStream = socket.getOutputStream();
           dataOutputStream = new DataOutputStream(outputStream);

           while (true) {

               String clientMessage = dataInputStream.readUTF();
               System.out.println("clientMessage : "+clientMessage);
               //Client에서 온 걸 읽는다.
               //→

               //←
               dataOutputStream.writeUTF("메시지 전송 완료!");
               dataOutputStream.flush();

               if (clientMessage.equals("STOP")) break;
           }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //자원해제
            try {
                if (socket != null) socket.close();
                if (inputStream != null) inputStream.close();
                if (dataInputStream != null) dataInputStream.close();
                if (outputStream != null) outputStream.close();
                if (dataOutputStream != null) dataOutputStream.close();

                if (serverSocket != null) serverSocket.close();
            } catch (Exception e) {

            }
        }

        /*
        네트워크와 관련된 것들은 거의다 예외처리 해줌.
         */

        //응답을 해주는 것을 만들어주지 않았기 때문에 웹 상에선 아무것도 뜨지 않음.
    }
}
