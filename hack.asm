CUR_GAME_STATE          equ $c320
GAME_STATE_DIGDUG       equ $04
GAME_STATE_NEW_DIGDUG   equ $0a

SECTION "init_game_state", ROMX[$436b], BANK[5]
        call    my_code
        nop

SECTION "my_code", ROMX[$7b00], BANK[5]
my_code::
        ld      hl, CUR_GAME_STATE+1
        xor     a
        ld      [hl-], a
IF NEW == 1
        ld      a, GAME_STATE_NEW_DIGDUG
        ld      [hl], a
        ld      a, $ff
        ld      [$de18], a
ELSE
        ld      a, GAME_STATE_DIGDUG
        ld      [hl], a
        xor     a
        ld      [$de18], a
ENDC
        ret
