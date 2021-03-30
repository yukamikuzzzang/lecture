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

TV::TV(int a){
	ch = a;
	cout<<"1. TV를 켰습니다."<<endl; 
}

int TV::nowCh(int b){
	ch = ch+b;
	cout<<"현재채널:"<<endl; 
	
	if(ch>15){
		ch = c%15;
	} 
	if(ch<1){
		ch=ch+15;
	}
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
			break;
	}
	
}



int main(){
int con = 0;
TV ss(7);//번호
ss.nowCh(con);
while(1){	
	cout<<"선택하세요"<<endl<<"3,4:채널UP/DOWN / 1:TV 끔."<<endl; 
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
	 }
	 else if(con == 4)
	 {
	 	con = -1;
	 	cout<<"채널내리기: "<<endl;	
	 } 
	 ss.nowCh(con);
	 con = 0; 
	}	
	
	return 0;	
 
}
