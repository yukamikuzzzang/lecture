package e20211228.Networking;

import java.net.ServerSocket;
import java.net.Socket;

public class MainClassServer {
    public static void main(String[] args) {
        ServerSocket serverSocket = null;
        Socket socket = null;

        try {
            serverSocket = new ServerSocket(9000);   //서버 소켓 생성 완료!
            System.out.println("클라이언트 맞을 준비 완료!");

            socket = serverSocket.accept(); //socket 객체를 반환 with .accept()
            System.out.println("클라이언트 연결");
            System.out.println("socket : " + socket);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //자원해제
            try{
                if(socket != null) socket.close();
                if(serverSocket != null) serverSocket.close();
            } catch (Exception e){

            }
        }

        /*
        네트워크와 관련된 것들은 거의다 예외처리 해줌.
         */

        //응답을 해주는 것을 만들어주지 않았기 때문에 웹 상에선 아무것도 뜨지 않음.
    }
}
