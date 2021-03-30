#include <iostream>
using namespace std;
class TV{
	private:
		int ch;
	public:
		TV(int a);
		int chUp(int b);
		int nowCh(int c);
		
};	
	
//int TV::chUp(int b){
//	
//}
//
//int TV::chDown(int b){
//	
//}

int TV::nowCh(int c){
	ch = ch+c;
	cout<<"현재채널:"<<endl; 
	
//	if(c>15){
//		c = c%15;
//	} 
	switch(ch)
	{
		case 5:
			cout<<ch<<": SBS 입니다."<<endl;
			break;
		case 7:
			cout<<ch<<": KBS2 입니다."<<endl;
			break;
		case 9:
			cout<<ch<<": KBS1 입니다."<<endl;
			break;
		case 11:
			cout<<ch<<": MBC 입니다."<<endl;
			break;
		case 13:
			cout<<ch<<": EBS 입니다."<<endl;
			break;
		default:
			cout<<ch<<": 홈쇼핑 입니다."<<endl;
	}
}

TV::TV(int a){
	ch = a;
	cout<<"1. TV를 켰습니다."<<endl; 
	//nowCh(ch);
}


	


int main(){
int con = 0;

while(1){
	TV ss(7);//번호
	ss.nowCh(con);
	cout<<"선택하세요"<<"3,4:채널UP/DOWN / 1:TV 끔."<<endl; 
 	cin>>con;
 	
 	if(con == 1)
	 {
 		cout<<"5. TV를 껐습니다."<<endl;
 		break;
	 }
 	else if(con == 3)
	 {
 		con = 1;
 		cout<<"채널올리기: "<<endl;
 		ss.nowCh(con);
	 }
	 else if(con == 4)
	 {
	 	con = -1;
	 	cout<<"채널내리기: "<<endl;
	 	ss.nowCh(con);
	 } 
	 con = 0; 
}	


return 0;	
} 
