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
	cout<<"����ä��:"<<endl; 
	
//	if(c>15){
//		c = c%15;
//	} 
	switch(ch)
	{
		case 5:
			cout<<ch<<": SBS �Դϴ�."<<endl;
			break;
		case 7:
			cout<<ch<<": KBS2 �Դϴ�."<<endl;
			break;
		case 9:
			cout<<ch<<": KBS1 �Դϴ�."<<endl;
			break;
		case 11:
			cout<<ch<<": MBC �Դϴ�."<<endl;
			break;
		case 13:
			cout<<ch<<": EBS �Դϴ�."<<endl;
			break;
		default:
			cout<<ch<<": Ȩ���� �Դϴ�."<<endl;
	}
}

TV::TV(int a){
	ch = a;
	cout<<"1. TV�� �׽��ϴ�."<<endl; 
	//nowCh(ch);
}


	


int main(){
int con = 0;

while(1){
	TV ss(7);//��ȣ
	ss.nowCh(con);
	cout<<"�����ϼ���"<<"3,4:ä��UP/DOWN / 1:TV ��."<<endl; 
 	cin>>con;
 	
 	if(con == 1)
	 {
 		cout<<"5. TV�� �����ϴ�."<<endl;
 		break;
	 }
 	else if(con == 3)
	 {
 		con = 1;
 		cout<<"ä�οø���: "<<endl;
 		ss.nowCh(con);
	 }
	 else if(con == 4)
	 {
	 	con = -1;
	 	cout<<"ä�γ�����: "<<endl;
	 	ss.nowCh(con);
	 } 
	 con = 0; 
}	


return 0;	
} 
