/*
 * @file ccn_dhcp.h
 */

#define CCN_DHCP_URI "ccnx:/local/dhcp"
#define CCN_DHCP_CONTENT_URI "ccnx:/local/dhcp/content"
#define CCN_DHCP_ADDR "224.0.0.66"
#define CCN_DHCP_PORT "60006"
#define CCN_DHCP_LIFETIME ((~0U) >> 1)
#define CCN_DHCP_MCASTTTL (-1)

struct ccn_dhcp_content {
    struct ccn_charbuf *name_prefix;
    const char *address;
    const char *port;
    struct ccn_charbuf *store;
};

void join_dhcp_group(struct ccn *h);

struct ccn_dhcp_content *ccn_dhcp_content_parse(const unsigned char *p, size_t size);

void ccn_dhcp_content_destroy(struct ccn_dhcp_content **dc);

int ccnb_append_dhcp_content(struct ccn_charbuf *c, const struct ccn_dhcp_content *dc);