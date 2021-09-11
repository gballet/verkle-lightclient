const std = @import("std");
const hash = [32]u8;
const address = [20]u8;
const big = std.math.big;
const nonce = [8]u8;

const BloomByteLength = 256;

const Bloom = [BloomByteLength]u8;

const Header = struct {
    parentHash: hash,
    uncleHash: hash,
    coinbase: address,
    root: hash,
    txHash: hash,
    receiptHash: hash,
    bloom: Bloom,
    difficulty: big.Int,
    number: big.Int,
    gasLimit: uint64,
    gasUsed: uint64,
    time: uint64,
    extra: []const u8,
    mixDigest: hash,
    nonce: nonce,

    // BaseFee was added by EIP-1559 and is ignored in legacy headers.
    baseFee: ?big.Int,

    // The verkle proof is ignored in legacy headers
    VerkleProof: ?[]u8,
};

const Block = struct {
    header: *Header,
    uncles: []*Header,
    txs: []*Tx,
    td: big.Int,
};

const Tx = struct {
    chainId: big.Int,
    nonce: u64,
    gasPrice: big.Int,
    gas: u64,
    to: ?address, // null => contract creation
    value: big.Int,
    data: []const u8,
    accessList: [].{ address, hash },
    v: big.Int,
    r: big.Int,
    s: big.Int,
};
