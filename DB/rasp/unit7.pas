unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  LCLProc, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpspreadsheet, fpsallformats, fpspreadsheetgrid, Variants, xlsbiff8, xlsbiff5,
  xlsbiff2, xlsxooxml, fpsopendocument, sqldb;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    ImportSQL: TSQLQuery;
    CheckSQL: TSQLQuery;
    Memo1: TMemo;
    ImportPredm: TSQLQuery;
    CheckPredm: TSQLQuery;
    ImportRasp: TSQLQuery;
    SQLQuery4: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form6: TForm6;
  MyWorkbook: TsWorkbook;
  MyWorksheet: TsWorksheet;
  InputFilename: string;
  MyDir: string;

implementation
uses Unit1, Unit2;
{$R *.lfm}

{ TForm6 }

procedure TForm6.FormCreate(Sender: TObject);
var
  i, j: integer;
begin
       // Open the input file
       MyDir := ExtractFilePath(ParamStr(0));

       //InputFileName
       InputFileName := MyDir + 'Raspisanie_14-1' + STR_EXCEL_EXTENSION;

       // Create the spreadsheet
       MyWorkbook := TsWorkbook.Create;
       MyWorkbook.ReadFromFile(InputFilename, sfExcel8);

       MyWorksheet := MyWorkbook.GetFirstWorksheet;
       edit1.Text:=InputFileName;
end;

procedure TForm6.Label1Click(Sender: TObject);
begin

end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   MyWorkbook.Free;
   DataModule1.SQLTransaction1.CommitRetaining();
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  i, j: integer;
  nGrpEmpty, gCnt : integer;
  GroupName: string;
begin
  GroupName:=''; nGrpEmpty:=0; j:=0;

   while (nGrpEmpty<10) and (j<100) do
   begin
       GroupName:=MyWorksheet.ReadAsUTF8Text(1,j);
       Inc(j);
       GroupName:=Trim(GroupName);                         // Empty GroupName
       if GroupName='' then
        begin
//        inc(nGrpEmpty);
          continue;
        end;

       CheckSQL.ParamByName('gName').AsString:=GroupName;   // Duplication
       CheckSQL.Open;
       gCnt:=CheckSQL.FieldByName('gCount').AsInteger;
       CheckSQL.Close;
       if gCnt>0 then continue;

       ImportSQL.ParamByName('gName').AsString:=GroupName;
       ImportSQL.ExecSQL;
       Memo1.Lines.Add(GroupName);
  end;
  DataModule1.SQLTransaction1.CommitRetaining();
  datamodule1.SQLQuery3.close;
  datamodule1.SQLQuery3.open;
end;

function IsNumeric(s : char) : boolean;
begin
  Result:=(s>='0') and (s<='9');
end;

procedure TForm6.Button2Click(Sender: TObject);
var
  col, l, i, j: integer;
  nPrdmEmpty, pCnt : integer;
  PredmName: string;
  n, k: Integer;
begin
  PredmName:='';

  i:=2;
  while i<200 do
   begin
    j:=3;
    while j<72 do
     begin
      for l:=j to j+10 do
       begin
            PredmName:=MyWorksheet.ReadAsUTF8Text(j,l);

            PredmName:=Trim(PredmName);                         // Empty PredmName
            if (PredmName='') or IsNumeric(PredmName[1]) then
            begin
             continue;
            end;

            CheckPredm.ParamByName('pName').AsString:=PredmName;   // Duplication
            CheckPredm.Open;
            pCnt:=CheckPredm.FieldByName('pCount').AsInteger;
            CheckPredm.Close;
            if pCnt>0 then continue;

            ImportPredm.ParamByName('pName').AsString:=PredmName;
            ImportPredm.ExecSQL;

            Memo1.Lines.Add(PredmName);
       end;
      j:=j+12;
     end;
    i:=i+3;
   end;

  DataModule1.SQLTransaction1.CommitRetaining();
  datamodule1.SQLQuery4.close;
  datamodule1.SQLQuery4.open;
end;

procedure TForm6.Button3Click(Sender: TObject);
var
  i,j,l,k:integer;
  GroupName, nUroka, PredmName, RaspDen, kabName:string;
begin
  i:=0;
  while i<100 do
   begin
       GroupName:=MyWorksheet.ReadAsUTF8Text(1,i);
       Inc(i);
       GroupName:=Trim(GroupName);                         // Empty GroupName
       if GroupName='' then
        begin
//        inc(nGrpEmpty);
          continue;
        end;

       //Groups.Locate('Groupname',Groupname);
       //GroupID :=Groups.FieldByName('id').asinteger;

        for j:=3 to 100 do
         begin
         for l:=2 to 63 do
           begin
             PredmName:=MyWorksheet.ReadAsUTF8Text(l,j);
             nUroka:=MyWorksheet.ReadAsUTF8Text(l-1,j);
             kabName:=MyWorksheet.ReadAsUTF8Text(l+1,j);

             PredmName:=Trim(PredmName);
             if (PredmName='') then
             begin
              continue;
             end;

             //(:RaspDen,:GroupID,:PredmID,:nUroka)

             ImportSQL.ParamByName('RaspDen').AsString:=RaspDen;
             ImportSQL.ParamByName('GroupName').AsString:=GroupName;
             ImportSQL.ParamByName('PREDMNAMEKRATK').AsString:=PredmName;
             ImportSQL.ParamByName('nUroka').AsString:=nUroka;
             ImportSQL.ParamByName('raspKab').AsString:=kabName;
             ImportSQL.ExecSQL;


             //Memo1.Lines.Add(nUroka);
           end;
         end;
       //Memo1.Lines.Add(RaspName);
  end;
  DataModule1.SQLTransaction1.CommitRetaining();
  datamodule1.SQLQuery2.close;
  datamodule1.SQLQuery2.open;
end;

end.

