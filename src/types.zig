const std = @import("std");
const hash = [32]u8;
const address = [20]u8;
const big = std.math.big;

pub const nonce = [8]u8;
pub const BloomByteLength = 256;
pub const Bloom = [BloomByteLength]u8;

pub const Header = struct {
    parentHash: hash,
    uncleHash: hash,
    coinbase: address,
    root: hash,
    txHash: hash,
    receiptHash: hash,
    bloom: Bloom,
    difficulty: big.int,
    number: big.int,
    gasLimit: u4,
    gasUsed: u4,
    time: u4,
    extra: []const u8,
    mixDigest: hash,
    nonce: nonce,

    // BaseFee was added by EIP-1559 and is ignored in legacy headers.
    baseFee: ?big.int,

    // The verkle proof is ignored in legacy headers
    VerkleProof: ?[]u8,
};

pub const Block = struct {
    header: *Header,
    uncles: []*Header,
    txs: []*Tx,
    td: big.int,
};

pub const AccessListPair = struct {
    address: address,
    hash: hash,
};

pub const Tx = struct {
    chainId: big.int,
    nonce: u64,
    gasPrice: big.int,
    gas: u64,
    to: ?address, // null => contract creation
    value: big.int,
    data: []const u8,
    accessList: []AccessListPair,
    v: big.int,
    r: big.int,
    s: big.int,
};
