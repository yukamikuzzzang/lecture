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
	cout<<"1. TV�� �׽��ϴ�."<<endl; 
}

int TV::nowCh(int b){
	ch = ch+b;
	cout<<"����ä��:"<<endl; 
	
	if(ch>15){
		ch = c%15;
	} 
	if(ch<1){
		ch=ch+15;
	}
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
			break;
	}
	
}



int main(){
int con = 0;
TV ss(7);//��ȣ
ss.nowCh(con);
while(1){	
	cout<<"�����ϼ���"<<endl<<"3,4:ä��UP/DOWN / 1:TV ��."<<endl; 
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
	 }
	 else if(con == 4)
	 {
	 	con = -1;
	 	cout<<"ä�γ�����: "<<endl;	
	 } 
	 ss.nowCh(con);
	 con = 0; 
	}	
	
	return 0;	
 
}
