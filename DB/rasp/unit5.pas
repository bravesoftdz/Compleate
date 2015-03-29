unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  DBGrids, StdCtrls, ExtCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation
uses Unit1, Unit2, Unit3, Unit4, Unit6;
{$R *.lfm}

{ TForm4 }

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DataModule1.SQLQuery4.Close;;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
    datamodule1.IBconnection1.close;
    datamodule1.IBconnection1.open;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
     Form5.show;
end;

end.

