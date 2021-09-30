const std = @import("std");
const types = @import("types.zig");
const deserialize = @import("rlp.zig").deserialize;

pub fn main() anyerror!void {
    // https://etherscan.io/tx/0x2c9931793876db33b1a9aad123ad4921dfb9cd5e59dbb78ce78f277759587115
    const txHex = "f90139018205c287bd28c8360cb33388019b4fce1409b3338302967b94ed9d63a96c27f87b07115b56b2e3572827f2164680b8c4dccad524005f4a2f15f455548e630c03da45f6aa6a2a5c593421f07ff844a530f42346cf02ce625e94458d39dd0bf3b45a843544dd4a14b8169045a3a3d15aa564b936c50000000000000000000000000000000000000000000000000000000027ae9b32000000000000000000000000000000000000000000000000000000174876e800000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec70000000000000000000000000000000000000000000000000000000000000001c001a0c4c494c632ed276b58a3b9eaffa940e7bb9de8219219f841380034f7dfcc1bcca00ae46745570e184718cf56eb3eeebdff88b63272a8a4e94d8ab02cb51de26fee";
    var txRLP: [txHex.len / 2]u8 = undefined;
    var tx: types.Tx = undefined;
    _ = try std.fmt.hexToBytes(txRLP[0..], txHex);
    _ = try deserialize(types.Tx, txRLP[0..], &tx);

    std.debug.print("nonce={}\n", .{tx.nonce});
    std.debug.print("gas tip cap={}\n", .{std.fmt.fmtSliceHexLower(tx.gasTipCap[0..])});
    std.debug.print("gas fee cap={}\n", .{std.fmt.fmtSliceHexLower(tx.gasFeeCap[0..])});
    std.debug.print("gas={}\n", .{tx.gas});
    std.debug.print("to={}\n", .{std.fmt.fmtSliceHexLower(tx.to.?[0..])});
    std.debug.print("value={}\n", .{std.fmt.fmtSliceHexLower(tx.value[0..])});
}
