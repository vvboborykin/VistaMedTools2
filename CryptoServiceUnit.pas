{*******************************************************
* Project: VistaMedTools2
* Unit: CryptoServiceUnit.pas
* Description: ������ ��������� ������
*
* Created: 01.04.2025 15:13:47
* Copyright (C) 2025 ��������� �.�. (bpost@yandex.ru)
*******************************************************}
unit CryptoServiceUnit;

interface

uses
  SysUtils, Classes, Variants, StrUtils;

type
  /// <summary>TCryptoService
  /// ������ ��������� ������
  /// </summary>
  TCryptoService = class
  public
    /// <summary>TCryptoService.EncryptString
    /// ����������� ������
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASource"> (string) �������� ������</param>
    /// <param name="APassword"> (string) ������</param>
    function EncryptString(ASource, APassword: string): string;
    /// <summary>TCryptoService.DecryptString
    /// ������������ ������
    /// </summary>
    /// <returns> string
    /// </returns>
    /// <param name="ASource"> (string) ������������� ������</param>
    /// <param name="APassword"> (string) ������</param>
    function DecryptString(ASource, APassword: string): string;
  end;

  /// <summary>procedure CryptoService
  /// �������� ������ TCryptoService
  /// </summary>
  /// <returns> TCryptoService
  /// </returns>
  function CryptoService: TCryptoService;

implementation

uses
  DCPblowfish, DCPsha512, DCPcrypt2;

var
  FSingleton: TCryptoService;

  function CryptoService: TCryptoService;
  begin
    Result := FSingleton;
  end;

function TCryptoService.DecryptString(ASource, APassword: string): string;
var
  vChipher: TDCP_blowfish;
begin
  vChipher := TDCP_blowfish.Create(nil);
  try
    vChipher.InitStr(APassword, TDCP_sha512);
    Result := vChipher.DecryptString(ASource);
  finally
    vChipher.Burn;
    vChipher.Free;
  end;
end;

function TCryptoService.EncryptString(ASource, APassword: string): string;
var
  vChipher: TDCP_blowfish;
begin
  vChipher := TDCP_blowfish.Create(nil);
  try
    vChipher.InitStr(APassword, TDCP_sha512);
    Result := vChipher.EncryptString(ASource);
  finally
    vChipher.Burn;
    vChipher.Free;
  end;
end;

initialization
  FSingleton := TCryptoService.Create;
finalization
  FreeAndNil(FSingleton);
end.
