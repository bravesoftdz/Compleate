unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  DBGrids, StdCtrls, ComCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form5: TForm5;

implementation
uses Unit1, Unit2, Unit3, Unit4, Unit5;
{$R *.lfm}

{ TForm5 }

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   //  DataModule1.SQLQuery5.Close;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  datamodule1.IBconnection1.close;
  datamodule1.IBconnection1.open;
end;

procedure TForm5.StatusBar1Click(Sender: TObject);
begin
     {datamodule1.SQLQuery12.SQL.Add('select sum(semestrchasov) from nSemestrawhere predmid=:predmid');
     datamodule1.SQLQuery12.Open;}
  statusbar1.SimpleText:='Часов на семестр: '+inttostr(datamodule1.SQLQuery5.FieldValues['semestrchasov'])+' / '+'Часов всего: '+inttostr(datamodule1.SQLQuery4.FieldValues['predmchasov']);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
    DataModule1.SQLTransaction1.CommitRetaining();
end;

procedure TForm5.DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
begin

end;

end.

