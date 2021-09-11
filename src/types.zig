const std = @import("std");
const hash = [32]u8;
const address = [20]u8;

const U256 = [32]u8;

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
    difficulty: U256,
    number: U256,
    gasLimit: u4,
    gasUsed: u4,
    time: u4,
    extra: []const u8,
    mixDigest: hash,
    nonce: nonce,

    // BaseFee was added by EIP-1559 and is ignored in legacy headers.
    baseFee: ?U256,

    // The verkle proof is ignored in legacy headers
    VerkleProof: ?[]u8,
};

pub const Block = struct {
    header: *Header,
    uncles: []*Header,
    txs: []*Tx,
    td: U256,
};

pub const AccessListPair = struct {
    address: address,
    hash: hash,
};

pub const Tx = struct {
    chainId: U256,
    nonce: u64,
    gasPrice: U256,
    gas: u64,
    to: ?address, // null => contract creation
    value: U256,
    data: []const u8,
    accessList: []AccessListPair,
    v: U256,
    r: U256,
    s: U256,
};
