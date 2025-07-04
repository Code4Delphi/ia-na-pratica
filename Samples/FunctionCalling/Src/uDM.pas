unit uDM;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    TBVendas: TFDQuery;
    TBVendasId: TFDAutoIncField;
    TBVendasid_cliente: TIntegerField;
    TBVendasClienteNome: TWideStringField;
    TBVendasdata: TWideStringField;
    TBVendastotal: TFloatField;
    TBClientes: TFDQuery;
    TBClientesId: TFDAutoIncField;
    TBClientesnome: TWideStringField;
    TBProdutos: TFDQuery;
    TBProdutosid: TFDAutoIncField;
    TBProdutosnome: TWideStringField;
    TBProdutosestoque: TFloatField;
    TBProdutospreco: TFloatField;
    TBProdutosregistro: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSqlTBProdutos: string;
    FSqlTBVendas: string;
  public
    procedure ProdutosGet(const AId: Integer);
    procedure ClienteGet(const AId: Integer);
    procedure VendasListar(ADataIni, ADataFim: TDate);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FSqlTBProdutos := TBProdutos.SQL.Text;
  FSqlTBVendas := TBVendas.SQL.Text;
end;

procedure TDM.ProdutosGet(const AId: Integer);
begin
  TBProdutos.Close;
  TBProdutos.SQL.Text := FSqlTBProdutos;
  TBProdutos.SQL.Add('where id = :IdProduto');
  TBProdutos.ParamByName('IdProduto').AsInteger := AId;
  TBProdutos.Open;
end;

procedure TDM.ClienteGet(const AId: Integer);
begin
  TBClientes.Close;
  TBClientes.ParamByName('IdCliente').AsInteger := AId;
  TBClientes.Open;
end;

procedure TDM.VendasListar(ADataIni, ADataFim: TDate);
begin
  if ADataFim <= 0 then
    ADataFim := ADataIni;

  TBVendas.Close;
  TBVendas.SQL.Text := FSqlTBVendas;
  TBVendas.SQL.Add('where data between :DataIni and :DataFim');
  TBVendas.ParamByName('DataIni').AsDate := ADataIni;
  TBVendas.ParamByName('DataFim').AsDate := ADataFim;
  TBVendas.Open;
end;

end.
